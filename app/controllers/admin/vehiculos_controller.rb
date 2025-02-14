class Admin::VehiculosController < ApplicationController
  include AdminCheck
  before_action :authenticate_user!
  before_action :set_vehiculo, only: [:accept, :decline, :download_pdf, :preview_pdf, :validate_status_vehicle]
  before_action :validate_status_vehicle, only: [:download_pdf, :preview_pdf]

  require_dependency 'pdf_generator_service'

  def accept
    @vehiculo.update(status: :active)
    redirect_to admin_user_path(@vehiculo.user), notice: "Vehículo aceptado correctamente."
  end

  def decline
    @vehiculo.update(status: :inactive)
    redirect_to admin_user_path(@vehiculo.user), notice: "Vehículo rechazado correctamente."
  end

  def download_pdf
    pdf = PdfGeneratorService.new(@vehiculo).generate_pdf
    send_pdf(pdf, "vehiculo_#{@vehiculo.id}_#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf")
  end

  def preview_pdf
    pdf = PdfGeneratorService.new(@vehiculo).generate_pdf
    pdf.start_new_page
    send_pdf(pdf, "vehiculo_#{@vehiculo.id}_#{Time.now}.pdf")
  end

  def validate_status_vehicle
    if !@vehiculo.active?
      flash[:alert] = "Sin acceso"
      redirect_to admin_user_path(@vehiculo.user)
    end
  end

  private 

  
  def set_vehiculo
    @vehiculo = Vehiculo.find(params[:id])
  end

  def send_pdf(pdf, filename)
    send_data(pdf.render,
      filename: filename,
      type: "application/pdf",
      disposition: "inline"
    )
  end
end