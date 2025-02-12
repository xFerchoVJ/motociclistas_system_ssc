class PasesTuristico < ApplicationRecord
  belongs_to :user
  validates :fecha_emision, presence: true
  validates :duracion_dias, presence: true
  validates :qr_code, presence: true
end