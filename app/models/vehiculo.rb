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

  after_update :generate_qr_if_active

  private

  def generate_qr_if_active
    if saved_change_to_status? && active?
      # Obtener el host desde .env o usar localhost como predeterminado
      host = ENV.fetch('APP_HOST', 'localhost:3000')
      protocol = Rails.env.production? ? 'https' : 'http'
      public_url = Rails.application.routes.url_helpers.public_show_vehicle_url(self, host: host, protocol: protocol)
      begin
        qr = RQRCode::QRCode.new(public_url)
        png = qr.as_png(size: 300)
        self.qr_code = "data:image/png;base64,#{Base64.strict_encode64(png.to_s)}"
        save!
      rescue => e
        Rails.logger.error "Error al generar el QR: #{e.message}"
      end
    end
  end
end