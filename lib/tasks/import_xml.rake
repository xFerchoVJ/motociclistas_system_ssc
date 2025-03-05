namespace :import do
  desc "Import states, municipalities, settlements, and postal codes from XML"
  task xml: :environment do
    require 'nokogiri'

    file_path = Rails.root.join('db', 'data', 'CPdescarga.xml')
    xml_data = File.read(file_path)
    doc = Nokogiri::XML(xml_data)

    ns = { "ns" => "NewDataSet" }
    tables = doc.xpath("//ns:table", ns)

    tables.each do |table|
      estado_nombre = table.xpath("ns:d_estado", ns).text
      estado_clave = table.xpath("ns:c_estado", ns).text
      estado = Estado.find_or_create_by(nombre: estado_nombre, clave: estado_clave)

      municipio_nombre = table.xpath("ns:D_mnpio", ns).text
      municipio_clave = table.xpath("ns:c_mnpio", ns).text
      municipio = estado.municipios.find_or_create_by(nombre: municipio_nombre, clave: municipio_clave)

      asentamiento_nombre = table.xpath("ns:d_asenta", ns).text
      asentamiento_tipo = table.xpath("ns:d_tipo_asenta", ns).text
      asentamiento = municipio.asentamientos.find_or_create_by(nombre: asentamiento_nombre, tipo: asentamiento_tipo)

      codigo_postal = table.xpath("ns:d_codigo", ns).text
      asentamiento.codigos_postales.find_or_create_by(codigo: codigo_postal)
    end

    puts "Datos importados exitosamente!"
  end
end