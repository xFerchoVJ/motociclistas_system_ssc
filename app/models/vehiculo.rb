class Vehiculo < ApplicationRecord
  belongs_to :user

  validates :placa, 
            uniqueness: { message: "La placa ya está registrada. Por favor, utiliza una placa única." }, 
            presence: { message: "La placa es obligatoria. No puede estar en blanco." }

  validates :vin, 
            uniqueness: { message: "El VIN ya está registrado. Por favor, utiliza un VIN único." }, 
            presence: { message: "El VIN es obligatorio. No puede estar en blanco." }
end