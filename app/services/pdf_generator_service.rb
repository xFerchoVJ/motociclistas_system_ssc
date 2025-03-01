class PdfGeneratorService
  def initialize(resource)
    @resource = resource
  end

  def generate_pdf
    pdf = Prawn::Document.new
    if @resource.is_a?(Vehiculo)
      generate_vehiculo_pdf(pdf)
    elsif @resource.is_a?(User)
      generate_user_pdf(pdf)
    end
    pdf
  end

  private

  def generate_vehiculo_pdf(pdf)
    # Agregar la imagen al encabezado
    add_header_image(pdf)

    pdf.move_down 30
    pdf.text_box "Constancia de Inscripción en el Registro oficial de Motociclismo", size: 24, style: :bold, at: [60, pdf.cursor], align: :right
    pdf.move_down 70

    pdf.stroke_color 'AB0A3D'
    pdf.stroke do
      pdf.line_width 5
      pdf.horizontal_rule
    end
    pdf.move_down 30

    pdf.text "Información", size: 18, style: :bold
    pdf.move_down 10

    user = @resource.user

    usuario_data = [
      ["Nombre:", user.nombre],
      ["Apellido Paterno:", user.apellido_paterno],
      ["Apellido Materno:", user.apellido_materno],
      ["Teléfono:", user.telefono],
      ["Estado:", user.estado],
      ["Municipio:", user.municipio],
      ["Marca:", @resource.marca],
      ["Modelo:", @resource.modelo],
      ["Linea:", @resource.linea],
      ["Placas:", @resource.placa]
    ]

    pdf.table(usuario_data, width: 350) do
      cells.padding = 8
      cells.borders = []
      column(0).font_style = :bold
    end

    if @resource.qr_code
      qr_image = @resource.qr_code.sub("data:image/png;base64,", "")
      image = StringIO.new(Base64.decode64(qr_image))
      pdf.bounding_box([350, pdf.cursor + 150], width: 150, height: 150) do
        pdf.image image, width: 150, height: 150
      end
    end
  end

  def generate_user_pdf(pdf)
    # Agregar la imagen al encabezado
    add_header_image(pdf)

    pdf.move_down 30
    pdf.text_box "Constancia de Registro oficial de Motociclismo", size: 24, style: :bold, at: [60, pdf.cursor], align: :right
    pdf.move_down 70

    pdf.stroke_color 'AB0A3D'
    pdf.stroke do
      pdf.line_width 5
      pdf.horizontal_rule
    end
    pdf.move_down 30

    pdf.text "Datos del Usuario", size: 18, style: :bold
    pdf.move_down 10

    user_data = [
      ["Nombre:", @resource.nombre],
      ["Apellido Paterno:", @resource.apellido_paterno],
      ["Apellido Materno:", @resource.apellido_materno],
      ["CURP:", @resource.curp],
      ["Teléfono:", @resource.telefono],
      ["Estado:", @resource.estado],
      ["Municipio:", @resource.municipio]
    ]

    pdf.table(user_data, width: 350) do
      cells.padding = 8
      cells.borders = []
      column(0).font_style = :bold
    end

    if @resource.constancias.where(status: true).first.qr_code?
      qr_image = @resource.constancias.where(status: true).first.qr_code.sub("data:image/png;base64,", "")
      image = StringIO.new(Base64.decode64(qr_image))
      pdf.bounding_box([350, pdf.cursor + 150], width: 150, height: 150) do
        pdf.image image, width: 150, height: 150
      end
    end

    pdf.move_down 50

    pdf.text "Fecha de vigencia - #{@resource.constancias.where(status: true).first.fecha_expiracion.strftime("%d/%m/%Y")}", size: 18, style: :bold, align: :center
  end

  # Método para agregar la imagen al encabezado
  def add_header_image(pdf)
    require 'open-uri' # Asegúrate de requerir open-uri
    require 'base64'   # Para manejar la codificación Base64
  
    # Leer la imagen desde la URL
    image_url = "https://res.cloudinary.com/djbzeisgm/image/upload/v1740808529/e7olgnrq5kaxgrombi7q.png"
    image_data = OpenURI.open_uri(image_url).read
  
    # Convertir la imagen a Base64
    image_base64 = Base64.strict_encode64(image_data)
  
    # Decodificar Base64 y crear un objeto StringIO
    decoded_image = Base64.decode64(image_base64)
    image_io = StringIO.new(decoded_image)
  
    # Insertar la imagen en el PDF
    pdf.bounding_box([pdf.bounds.right - 150, pdf.bounds.top], width: 150, height: 50) do
      pdf.image image_io, width: 150, height: 50
    end
  end
end