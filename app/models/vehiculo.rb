class Vehiculo < ApplicationRecord
  belongs_to :user

  # Validaciones
  validates :marca, 
            presence: { message: "La marca es obligatoria. No puede estar en blanco." }

  validates :modelo, 
            presence: { message: "El modelo es obligatorio. No puede estar en blanco." }

  validates :submarca, 
            presence: { message: "La submarca es obligatoria. No puede estar en blanco." }

  validates :anio, 
            presence: { message: "El año es obligatorio. No puede estar en blanco." },
            numericality: { 
              only_integer: true, 
              greater_than_or_equal_to: 1900, 
              less_than_or_equal_to: Date.today.year,
              message: "El año debe ser un número válido entre 1900 y el año actual."
            }

  validates :placa, 
            uniqueness: { message: "La placa ya está registrada. Por favor, utiliza una placa única." }, 
            presence: { message: "La placa es obligatoria. No puede estar en blanco." },
            format: {
              with: /\A[A-Z0-9]+\z/,
              message: "La placa solo puede contener letras mayúsculas y números."
            }

  validates :estado_emplacamiento, 
            presence: { message: "El estado de emplacamiento es obligatorio. No puede estar en blanco." }

  validates :vin, 
            uniqueness: { message: "El VIN ya está registrado. Por favor, utiliza un VIN único." }, 
            presence: { message: "El VIN es obligatorio. No puede estar en blanco." },
            length: {
              is: 17,
              message: "El VIN debe tener exactamente 17 caracteres."
            },
            format: {
              with: /\A[A-Z0-9]+\z/,
              message: "El VIN solo puede contener letras mayúsculas y números."
            }

  # Enums
  enum status: {
    in_progress: 0,
    active: 1,
    inactive: 2
  }, _default: :in_progress
end