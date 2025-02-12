class CreateVerificacions < ActiveRecord::Migration[7.1]
  def change
    create_table :verificacions do |t|
      t.string :codigo
      t.boolean :verificado_whatsapp
      t.boolean :verificado_correo
      t.boolean :verificado
      t.datetime :fecha_expiracion
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
