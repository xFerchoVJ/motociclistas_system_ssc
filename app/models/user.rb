class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum role: { user: 0, admin: 1 }
  enum status: {
    active: 1,
    inactive: 0
  }, _default: :active

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

  def soft_delete
    update(status: :inactive)
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : :deleted_account
  end


  # Método para filtrar con Ransack

  def self.ransackable_associations(auth_object = nil)
    ["club", "vehiculos"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[nombre apellido_paterno apellido_materno email curp telefono]
  end

  # Método para buscar por nombre completo
  ransacker :nombre_completo do
    Arel.sql("CONCAT(nombre, ' ', apellido_paterno, ' ', apellido_materno)")
  end


end