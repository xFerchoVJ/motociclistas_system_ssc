json.extract! appointment, :id, :user_id, :fecha, :hora, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
