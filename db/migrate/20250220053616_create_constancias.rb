class CreateConstancias < ActiveRecord::Migration[7.1]
  def change
    create_table :constancias do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vehiculo, foreign_key: true
      t.datetime :fecha_emision, null: false
      t.datetime :fecha_expiracion, null: false
      t.text :qr_code
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
