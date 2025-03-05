class CreateCodigoPostals < ActiveRecord::Migration[7.1]
  def change
    create_table :codigo_postals do |t|
      t.string :codigo
      t.references :asentamiento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
