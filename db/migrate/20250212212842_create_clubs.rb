class CreateClubs < ActiveRecord::Migration[7.1]
  def change
    create_table :clubs do |t|
      t.string :nombre
      t.string :direccion
      t.string :estado
      t.string :municipio
      t.string :telefono
      t.string :email
      t.string :representante

      t.timestamps
    end
  end
end
