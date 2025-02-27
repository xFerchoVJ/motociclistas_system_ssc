class Admin::AppointmentsController < ApplicationController
  include AdminCheck
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[ show edit update destroy confirm_appointment ]

  # GET /admin/appointments or /admin/appointments.json
  def index
    @appointments = Appointment.all().order(fecha: :desc)

    # Filtrar por status si se pasa como parámetro
    @appointments = @appointments.where(status: params[:status]) if params[:status].present?

    # Filtrar por fecha si se pasa como parámetro
    @appointments = @appointments.where(fecha: params[:fecha]) if params[:fecha].present?

    # Filtrar por hora si se pasa como parámetro
    if params[:hora].present?
      @appointments = @appointments.where(hora: Time.parse(params[:hora]).strftime("%H:%M"))
    end

    puts @appointments.any?
  end


  # GET /admin/appointments/1 or /admin/appointments/1.json
  def show
  end

  # GET /admin/appointments/new
  def new
    @appointment = Appointment.new
  
    # Obtener fechas llenas
    max_appointments_per_day = Appointment::ALLOWED_HOURS.count
    @full_dates = Appointment.group(:fecha).having("COUNT(*) >= ?", max_appointments_per_day).pluck(:fecha)
  end
  

  # GET /admin/appointments/1/edit
  def edit
  end

  # POST /admin/appointments or /admin/appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user_id = current_user.id

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: "La cita se creó correctamente." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/appointments/1 or /admin/appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: "La cita se actualizó correctamente." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/appointments/1 or /admin/appointments/1.json
  def destroy
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to appointments_path, status: :see_other, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm_appointment
    @appointment.update(status: 'completada')
    if @appointment.save
      redirect_to admin_user_path(@appointment.user_id), notice: "La cita se confirmo correctamente."
    else
      redirect_to admin_appointment_path(@appointment), alert: "No se pudo confirmar la cita."
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:user_id, :fecha, :hora)
    end
end
