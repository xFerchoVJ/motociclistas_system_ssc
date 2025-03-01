# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_28_223731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "fecha"
    t.time "hora"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "en progreso"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "nombre"
    t.string "direccion"
    t.string "estado"
    t.string "municipio"
    t.string "telefono"
    t.string "email"
    t.string "representante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "constancias", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vehiculo_id"
    t.datetime "fecha_emision", null: false
    t.datetime "fecha_expiracion", null: false
    t.text "qr_code"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_constancias_on_user_id"
    t.index ["vehiculo_id"], name: "index_constancias_on_vehiculo_id"
  end

  create_table "pases_turisticos", force: :cascade do |t|
    t.date "fecha_emision"
    t.integer "duracion_dias"
    t.text "qr_code"
    t.boolean "vigente"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pases_turisticos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre", null: false
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.string "curp", limit: 18
    t.string "estado"
    t.string "municipio"
    t.string "telefono", limit: 20
    t.boolean "es_turista", default: false
    t.integer "club_id"
    t.string "contacto_emergencia"
    t.string "telefono_emergencia", limit: 20
    t.boolean "donador_organos", default: false
    t.string "tipo_sangre", limit: 10
    t.text "alergias"
    t.text "medicamento_contraindicado"
    t.integer "role"
    t.integer "status", default: 1, null: false
    t.text "seguridad_medica"
    t.index ["curp"], name: "index_users_on_curp", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "vehiculos", force: :cascade do |t|
    t.string "marca"
    t.string "modelo"
    t.string "linea"
    t.string "placa"
    t.string "estado_emplacamiento"
    t.string "numero_serie"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.text "qr_code"
    t.string "tipo_servicio"
    t.index ["user_id"], name: "index_vehiculos_on_user_id"
  end

  create_table "verificacions", force: :cascade do |t|
    t.string "codigo"
    t.boolean "verificado_whatsapp"
    t.boolean "verificado_correo"
    t.boolean "verificado"
    t.datetime "fecha_expiracion"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_verificacions_on_user_id"
  end

  add_foreign_key "appointments", "users"
  add_foreign_key "constancias", "users"
  add_foreign_key "constancias", "vehiculos"
  add_foreign_key "pases_turisticos", "users"
  add_foreign_key "users", "clubs"
  add_foreign_key "vehiculos", "users"
  add_foreign_key "verificacions", "users"
end
