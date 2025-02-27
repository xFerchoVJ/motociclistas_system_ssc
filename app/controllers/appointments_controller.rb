class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: %i[ show edit update destroy cancelate_appointment ]

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.where(user_id: current_user.id)

    # Filtrar por status si se pasa como parámetro
    @appointments = @appointments.where(user_id: current_user.id, status: params[:status]) if params[:status].present?

    # Filtrar por fecha si se pasa como parámetro
    @appointments = @appointments.where(user_id: current_user.id, fecha: params[:fecha]) if params[:fecha].present?

    # Filtrar por hora si se pasa como parámetro
    if params[:hora].present?
      @appointments = @appointments.where(user_id: current_user.id, hora: Time.parse(params[:hora]).strftime("%H:%M"))
    end

    puts @appointments.any?
  end


  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  
    # Obtener fechas llenas
    max_appointments_per_day = Appointment::ALLOWED_HOURS.count
    @full_dates = Appointment.group(:fecha).having("COUNT(*) >= ?", max_appointments_per_day).pluck(:fecha)
  end
  

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
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

  # PATCH/PUT /appointments/1 or /appointments/1.json
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

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to appointments_path, status: :see_other, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  # GET /admin/appointments/available_times
  def available_times
    fecha = params[:fecha]
    return render json: { available_times: [] } if fecha.blank?

    taken_hours = Appointment.where(fecha: fecha, status: 'en progreso').pluck(:hora)
    available_times = Appointment::ALLOWED_HOURS.map { |t| t.strftime("%H:%M") } - taken_hours.map { |t| t.strftime("%H:%M") }

    render json: { available_times: available_times }
  end

  def cancelate_appointment
    @appointment.update(status: 'cancelada')
    if @appointment.save
      redirect_to appointments_path, notice: "La cita se canceló correctamente."
    else
      redirect_to appointments_path, alert: "No se pudo cancelar la cita."
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
