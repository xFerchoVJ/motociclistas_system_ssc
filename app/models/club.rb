class Club < ApplicationRecord
  has_many :users
  validates :nombre, uniqueness: true, presence: true
  validates :email, uniqueness: true
end