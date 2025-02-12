json.extract! vehiculo, :id, :marca, :modelo, :submarca, :anio, :placa, :estado_emplacamiento, :vin, :user_id, :created_at, :updated_at
json.url vehiculo_url(vehiculo, format: :json)
