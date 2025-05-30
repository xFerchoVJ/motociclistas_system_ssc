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
  attribute :tipo_persona, :string, default: "fisica" 

  # Validaciones generales
  validates :email, uniqueness: { message: "ya está en uso" }, presence: { message: "no puede estar en blanco" }
  validates :telefono, presence: { message: "no puede estar en blanco" }
  validates :role, presence: { message: "no puede estar en blanco" }
  validates :status, presence: { message: "no puede estar en blanco" }
  validates :club_id, presence: {message: "no puede estar en blanco"}

  # Validaciones específicas para tipo de persona
  with_options if: -> { tipo_persona == 'fisica' } do
    validates :nombre, presence: { message: "no puede estar en blanco" }
    validates :apellido_paterno, presence: { message: "no puede estar en blanco" }
    validates :apellido_materno, presence: { message: "no puede estar en blanco" }
    validates :curp, uniqueness: { message: "ya está en uso" }, length: { is: 18, wrong_length: "debe tener 18 caracteres" }
  end

  with_options if: -> { tipo_persona == 'moral' } do
    validates :rfc, presence: { message: "no puede estar en blanco" }
    validates :domicilio, presence: { message: "no puede estar en blanco" }
    validates :representante_legal, presence: { message: "no puede estar en blanco" }
  end

  # Relaciones
  belongs_to :club, optional: true
  has_many :vehiculos, dependent: :destroy
  has_many :constancias, dependent: :destroy
  has_many :appointments, dependent: :destroy

  # Métodos adicionales
  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}".strip if tipo_persona == 'fisica'
    representante_legal if tipo_persona == 'moral'
  end

  def soft_delete
    update(status: :inactive)
  end

  def active_for_authentication?
    super && (active? || in_progress?)
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

  def has_motorcycle_in_progress?
    vehiculos.exists?(status: :in_progress)
  end
  
end