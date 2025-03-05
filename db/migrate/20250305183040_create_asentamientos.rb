class CreateAsentamientos < ActiveRecord::Migration[7.1]
  def change
    create_table :asentamientos do |t|
      t.string :nombre
      t.string :tipo
      t.references :municipio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
