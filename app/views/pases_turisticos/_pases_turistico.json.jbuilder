json.extract! pases_turistico, :id, :fecha_emision, :duracion_dias, :qr_code, :vigente, :user_id, :created_at, :updated_at
json.url pases_turistico_url(pases_turistico, format: :json)
