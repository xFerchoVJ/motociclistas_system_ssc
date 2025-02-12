json.extract! verificacion, :id, :codigo, :verificado_whatsapp, :verificado_correo, :verificado, :fecha_expiracion, :user_id, :created_at, :updated_at
json.url verificacion_url(verificacion, format: :json)
