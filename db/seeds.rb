# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

def generar_curp_ficticio
  letras = ('A'..'Z').to_a
  numeros = ('0'..'9').to_a

  # Generar una cadena aleatoria de 18 caracteres (letras y números)
  (0...18).map do |i|
    if i < 4 # Los primeros 4 caracteres son letras
      letras.sample
    else # Los siguientes 14 caracteres son números
      numeros.sample
    end
  end.join
end


# Limpiar la base de datos antes de crear nuevos registros
Vehiculo.destroy_all
User.destroy_all
Club.destroy_all

# Estados y municipios de México
estados_municipios = {
  "Ciudad de México" => ["Coyoacán", "Benito Juárez", "Miguel Hidalgo", "Cuauhtémoc"],
  "Jalisco" => ["Guadalajara", "Zapopan", "Tlaquepaque", "Tonalá"],
  "Nuevo León" => ["Monterrey", "San Pedro Garza García", "Guadalupe", "Apodaca"],
  "Puebla" => ["Puebla", "Cholula", "Atlixco", "Tehuacán"],
  "Quintana Roo" => ["Cancún", "Playa del Carmen", "Chetumal", "Tulum"],
  "Yucatán" => ["Mérida", "Valladolid", "Progreso", "Tizimín"]
}

# Crear 1 administrador
admin = User.create!(
  nombre: "Admin",
  apellido_paterno: "Principal",
  apellido_materno: "Sistema",
  email: "admin@example.com",
  password: "password123",
  curp: generar_curp_ficticio,
  estado: "Ciudad de México",
  municipio: "Coyoacán",
  telefono: "5551234567",
  es_turista: false,
  contacto_emergencia: "Soporte Técnico",
  telefono_emergencia: "5557654321",
  donador_organos: true,
  tipo_sangre: "O+",
  alergias: "Ninguna",
  medicamento_contraindicado: "Ninguno",
  role: 1 # Administrador
)

# Crear 6 usuarios
users = []
6.times do |i|
  estado = estados_municipios.keys.sample
  municipio = estados_municipios[estado].sample

  users << User.create!(
    nombre: Faker::Name.name,
    apellido_paterno: Faker::Name.last_name,
    apellido_materno: Faker::Name.last_name,
    email: "user#{i + 1}@example.com",
    password: "password123",
    curp: generar_curp_ficticio,
    estado: estado,
    municipio: municipio,
    telefono: Faker::PhoneNumber.phone_number,
    es_turista: [true, false].sample,
    contacto_emergencia: Faker::Name.name,
    telefono_emergencia: Faker::PhoneNumber.phone_number,
    donador_organos: [true, false].sample,
    tipo_sangre: ["O+", "A-", "B+", "AB-"].sample,
    alergias: Faker::Lorem.sentence,
    medicamento_contraindicado: Faker::Lorem.sentence,
    role: 0 # Usuario normal
  )
end

# Crear clubes
club1 = Club.create!(
  nombre: "Club de Montaña",
  direccion: "Av. Insurgentes 123",
  estado: "Ciudad de México",
  municipio: "Coyoacán",
  telefono: "5551112233",
  email: "clubmontana@example.com",
  representante: "Juan Pérez"
)

club2 = Club.create!(
  nombre: "Club de Playa",
  direccion: "Calle Libertad 456",
  estado: "Quintana Roo",
  municipio: "Cancún",
  telefono: "3334445566",
  email: "clubplaya@example.com",
  representante: "Ana López"
)

# Asignar clubes a usuarios
admin.update(club_id: club1.id)
users[0..2].each { |user| user.update(club_id: club1.id) } # Primeros 3 usuarios al Club de Montaña
users[3..5].each { |user| user.update(club_id: club2.id) } # Últimos 3 usuarios al Club de Playa

# Crear vehículos diferentes para cada usuario
vehiculos_data = [
  { marca: "Toyota", modelo: "Corolla", submarca: "LE", anio: 2020, placa: "ABC123", estado_emplacamiento: "Ciudad de México", vin: "1HGCM82633A123456" },
  { marca: "Nissan", modelo: "Sentra", submarca: "SV", anio: 2018, placa: "XYZ789", estado_emplacamiento: "Jalisco", vin: "3N1AB7AP9BL123456" },
  { marca: "Honda", modelo: "Civic", submarca: "EX", anio: 2019, placa: "DEF456", estado_emplacamiento: "Nuevo León", vin: "2HGFC2F56KH123456" },
  { marca: "Ford", modelo: "Mustang", submarca: "GT", anio: 2021, placa: "GHI789", estado_emplacamiento: "Puebla", vin: "1FA6P8CFXL5123456" },
  { marca: "Chevrolet", modelo: "Camaro", submarca: "LT", anio: 2017, placa: "JKL012", estado_emplacamiento: "Quintana Roo", vin: "1G1FH1R75H0123456" },
  { marca: "Volkswagen", modelo: "Jetta", submarca: "GLI", anio: 2022, placa: "MNO345", estado_emplacamiento: "Yucatán", vin: "3VW5T7AU9NM123456" }
]

users.each_with_index do |user, index|
  Vehiculo.create!(
    marca: vehiculos_data[index][:marca],
    modelo: vehiculos_data[index][:modelo],
    submarca: vehiculos_data[index][:submarca],
    anio: vehiculos_data[index][:anio],
    placa: vehiculos_data[index][:placa],
    estado_emplacamiento: vehiculos_data[index][:estado_emplacamiento],
    vin: vehiculos_data[index][:vin],
    user_id: user.id
  )
end

puts "Datos de prueba creados exitosamente!"