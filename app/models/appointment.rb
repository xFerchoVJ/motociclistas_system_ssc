class Appointment < ApplicationRecord
  belongs_to :user

  # Horarios permitidos (8:00 AM - 5:00 PM en intervalos de 30 minutos)
  ALLOWED_HOURS = (8..16).flat_map { |h| [Time.zone.parse("#{h}:00"), Time.zone.parse("#{h}:30")] }

  # Status de la cita
  enum status: { en_progreso: 'en progreso', completada: 'completada', cancelada: 'cancelada' }

  # Validaciones
  validates :fecha, presence: { message: "La fecha es obligatoria" }
  validates :hora, presence: { message: "La hora es obligatoria" }
  validate :valid_schedule
  validate :one_appointment_per_day, unless: :is_updated?
  validate :time_slot_available, unless: :is_updated?
  validate :weekday_only

  private

  # Verifica que la hora seleccionada esté dentro del horario permitido
  def valid_schedule
    selected_time_formatted = fecha.to_time.change(hour: hora.hour, min: hora.min).strftime("%H:%M")
    allowed_hours_formatted = ALLOWED_HOURS.map { |h| h.strftime("%H:%M") }
    unless allowed_hours_formatted.include?(selected_time_formatted)
      errors.add(:hora, "Debe estar entre las 8:00 AM y 5:00 PM en intervalos de 30 minutos")
    end
  end


  # Solo se permite una cita por usuario por día
  def one_appointment_per_day
    if user.appointments.where(fecha: fecha, status: 'en_progreso').exists?
      errors.add(:fecha, "Ya tienes una cita programada para este día")
    end
  end

  # Verifica si el horario seleccionado ya está ocupado
  def time_slot_available
    if Appointment.exists?(fecha: fecha, hora: hora, status: 'en_progreso')
      errors.add(:hora, "Este horario ya está ocupado. Elige otro.")
    end
  end

  def is_updated?
    status == 'completada' || status == 'cancelada'
  end


  # Verifica que la fecha sea de lunes a viernes
  def weekday_only
    if fecha.wday == 0 || fecha.wday == 6
      errors.add(:fecha, "La cita debe ser en un día hábil (lunes a viernes)")
    end
  end
end
