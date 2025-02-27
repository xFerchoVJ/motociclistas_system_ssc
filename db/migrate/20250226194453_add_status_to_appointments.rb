class AddStatusToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :status, :string, default: "en progreso"
  end
end
