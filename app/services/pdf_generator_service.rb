class PdfGeneratorService
  def initialize(vehiculo)
    @vehiculo = vehiculo
  end

  def generate_pdf
    pdf = Prawn::Document.new
    pdf.text "Información del Vehículo", size: 24, style: :bold, align: :center
    pdf.move_down 20

    pdf.text "Datos del Vehículo", size: 18, style: :bold
    pdf.move_down 10

    vehiculo_data = [
      ["Marca:", @vehiculo.marca],
      ["Modelo:", @vehiculo.modelo],
      ["Submarca:", @vehiculo.submarca],
      ["Año:", @vehiculo.anio],
      ["Placa:", @vehiculo.placa],
      ["Estado de Emplacamiento:", @vehiculo.estado_emplacamiento],
      ["VIN:", @vehiculo.vin]
    ]

    pdf.table(vehiculo_data, width: 500) do
      cells.padding = 8
      cells.borders = []
      column(0).font_style = :bold
    end

    pdf.move_down 20

    pdf.text "Datos del Propietario", size: 18, style: :bold
    pdf.move_down 10

    user = @vehiculo.user

    usuario_data = [
      ["Nombre:", user.nombre],
      ["Apellido Paterno:", user.apellido_paterno],
      ["Apellido Materno:", user.apellido_materno],
      ["Teléfono:", user.telefono],
      ["Contacto de Emergencia:", user.contacto_emergencia],
      ["Teléfono de Emergencia:", user.telefono_emergencia],
      ["Club:", user.club.nombre]
    ]

    pdf.table(usuario_data, width: 500) do
      cells.padding = 8
      cells.borders = []
      column(0).font_style = :bold
    end

    
    pdf.move_down 300

    if @vehiculo.qr_code
      pdf.text "Código QR", size: 18, style: :bold
      pdf.move_down 10

      qr_image = @vehiculo.qr_code.sub("data:image/png;base64,", "")
      image = StringIO.new(Base64.decode64(qr_image))
      pdf.image image, width: 150, position: :center
    end

    pdf
  end
end
