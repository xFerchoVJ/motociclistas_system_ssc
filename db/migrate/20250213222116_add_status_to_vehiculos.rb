class AddStatusToVehiculos < ActiveRecord::Migration[7.1]
  def change
    add_column :vehiculos, :status, :integer, default: 0, null: false
  end
end
