class Vehiculo < ApplicationRecord
  belongs_to :user
  validates :placa, uniqueness: true, presence: true
  validates :vin, uniqueness: true, presence: true
end