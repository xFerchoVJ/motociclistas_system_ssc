class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.date :fecha
      t.time :hora

      t.timestamps
    end
  end
end
