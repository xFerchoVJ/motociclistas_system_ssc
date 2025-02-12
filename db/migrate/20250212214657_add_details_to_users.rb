class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    # Agregar columnas sin la restricción unique
    add_column :users, :nombre, :string, null: false
    add_column :users, :apellido_paterno, :string
    add_column :users, :apellido_materno, :string
    add_column :users, :curp, :string, limit: 18
    add_column :users, :estado, :string
    add_column :users, :municipio, :string
    add_column :users, :telefono, :string, limit: 20
    add_column :users, :es_turista, :boolean, default: false
    add_column :users, :club_id, :integer
    add_column :users, :contacto_emergencia, :string
    add_column :users, :telefono_emergencia, :string, limit: 20
    add_column :users, :donador_organos, :boolean, default: false
    add_column :users, :tipo_sangre, :string, limit: 10
    add_column :users, :alergias, :text
    add_column :users, :medicamento_contraindicado, :text

    
    add_index :users, :curp, unique: true

    
    add_foreign_key :users, :clubs, column: :club_id
  end
end
