class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum role: { user: 0, admin: 1 }
  enum status: {
    inactive: 0,
    active: 1,
    in_progress: 2,
  }, _default: :in_progress

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
    return :not_approved if in_progress?
    return :deleted_account unless active?
    super
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