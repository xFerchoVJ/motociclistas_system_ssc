class Verificacion < ApplicationRecord
  belongs_to :user
  validates :codigo, presence: true
  validates :fecha_expiracion, presence: true
end