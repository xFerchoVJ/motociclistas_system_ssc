class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Campos adicionales
  validates :nombre, presence: true
  validates :curp, uniqueness: true
  validates :email, uniqueness: true

  belongs_to :club, optional: true
  has_many :vehiculos
  has_many :pases_turisticos
  has_many :verificaciones
end