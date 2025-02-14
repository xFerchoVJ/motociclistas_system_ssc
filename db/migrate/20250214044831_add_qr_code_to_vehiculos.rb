class AddQrCodeToVehiculos < ActiveRecord::Migration[7.1]
  def change
    add_column :vehiculos, :qr_code, :text
  end
end
