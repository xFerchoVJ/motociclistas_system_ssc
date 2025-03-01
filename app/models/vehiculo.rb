class Vehiculo < ApplicationRecord
  belongs_to :user

  # Validaciones
  validates :marca, presence: { message: "La marca no puede estar en blanco" }, length: { maximum: 50 }
  validates :modelo, presence: { message: "El modelo no puede estar en blanco" }, length: { maximum: 50 }
  validates :linea, presence: { message: "La línea no puede estar en blanco" }, length: { maximum: 50 }
  validates :placa, presence: { message: "La placa no puede estar en blanco" }, uniqueness: { message: "La placa ya está registrada" }, length: { maximum: 20 }
  validates :estado_emplacamiento, presence: { message: "El estado de emplacamiento no puede estar en blanco" }, length: { maximum: 100 }
  validates :numero_serie, presence: { message: "El número de serie no puede estar en blanco" }, length: { maximum: 50 }
  validates :tipo_servicio, presence: { message: "El tipo de servicio no puede estar en blanco" }, inclusion: { in: ["Particular", "Servicio Público", "Empresa"], message: "no es un tipo de servicio válido" }

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
    # Agregar que si el estado cambia a inactivo o en progreso, se elimine el QR
    elsif saved_change_to_status? && (inactive? || in_progress?)
      self.qr_code = nil
      save!
    end
  end
end