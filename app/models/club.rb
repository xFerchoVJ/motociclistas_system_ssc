class Club < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :nombre, uniqueness: true, presence: true
  validates :email, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[nombre]
  end
end