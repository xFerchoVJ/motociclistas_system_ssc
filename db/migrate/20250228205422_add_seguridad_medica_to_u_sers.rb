class AddSeguridadMedicaToUSers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :seguridad_medica, :text
  end
end
