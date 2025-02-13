class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum para roles
  enum role: { user: 0, admin: 1 }

  attribute :es_turista, :boolean, default: false
  attribute :role, :integer, default: 0

  # Validaciones
  validates :nombre, presence: true
  validates :curp, uniqueness: true, length: { is: 18 }
  validates :email, uniqueness: true

  # Relaciones
  belongs_to :club, optional: true
  has_many :vehiculos, dependent: :destroy

  # Métodos adicionales
  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}".strip
  end
end