class CreateVehiculos < ActiveRecord::Migration[7.1]
  def change
    create_table :vehiculos do |t|
      t.string :marca
      t.string :modelo
      t.string :submarca
      t.integer :anio
      t.string :placa
      t.string :estado_emplacamiento
      t.string :vin
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
