class CreatePasesTuristicos < ActiveRecord::Migration[7.1]
  def change
    create_table :pases_turisticos do |t|
      t.date :fecha_emision
      t.integer :duracion_dias
      t.text :qr_code
      t.boolean :vigente
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
