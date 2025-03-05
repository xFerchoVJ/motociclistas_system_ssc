class Admin::UsersController < ApplicationController
  include AdminCheck
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show destroy reactivate approve_user generate_pdf view_pdf download_pdf]

  require_dependency 'pdf_generator_service'

  def index
    @q = User.where.not(role: 1).order(created_at: :desc).ransack(params[:q]) # Excluye administradores
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def approve_user
    if @user.update!(status: :active)
      redirect_to admin_users_path, notice: "Usuario aprobado correctamente"
    else
      redirect_to admin_users_path, alert: "No se pudo aprobar el usuario"
    end
  end
  
  def generate_pdf
    @constancia = Constancia.create(
      user: @user,
      fecha_emision: DateTime.now,
      fecha_expiracion: DateTime.now + 30.days,
    )
    @constancia.qr_code =  generate_qr_code(@user, @constancia.id)
    @constancia.save
    pdf = PdfGeneratorService.new(@user).generate_pdf
    send_data pdf.render, filename: "constancia_inscripcion_#{@user.id}_#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf",
                          type: 'application/pdf',
                          disposition: 'inline'
  end

  def view_pdf
    @constancia = @user.constancias.where(status: true).first
    pdf = PdfGeneratorService.new(@user).generate_pdf
    send_data pdf.render, filename: "constancia_inscripcion_#{@user.id}_#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf",
                          type: 'application/pdf',
                          disposition: 'inline'
  end

  def download_pdf
    @constancia = @user.constancias.order(created_at: :desc).first
    pdf = PdfGeneratorService.new(@user).generate_pdf
    send_data pdf.render, filename: "constancia_inscripcion_#{@user.id}_#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf",
                          type: 'application/pdf',
                          disposition: 'attachment'
  end

  def show
  end
  
  def destroy
    @user.soft_delete
    active_pdf = @user.constancias.where(status: true)
    if active_pdf.any?
      active_pdf.first.update(status: false, fecha_expiracion: DateTime.now)
    end
    redirect_to admin_users_path, notice: "Usuario desactivado correctamente"
  end

  def reactivate
    @user.update(status: :active)
    redirect_to admin_users_path, notice: "Usuario reactivado correctamente"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def generate_qr_code(user, constancia_id)
    host = ENV.fetch('APP_HOST', 'localhost:3000')
    protocol = Rails.env.production? ? 'https' : 'http'
    public_url = Rails.application.routes.url_helpers.info_user_url(user.id, host: host, protocol: protocol, constancia_id: constancia_id)
    begin
      qr = RQRCode::QRCode.new(public_url)
      png = qr.as_png(size: 300)
      qr_code = "data:image/png;base64,#{Base64.strict_encode64(png.to_s)}"
      qr_code
    rescue => e
      Rails.logger.error "Error al generar el QR: #{e.message}"
    end
  end
end