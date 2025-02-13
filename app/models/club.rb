class Club < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :nombre, uniqueness: true, presence: true
  validates :email, uniqueness: true
end