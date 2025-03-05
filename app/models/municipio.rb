class Municipio < ApplicationRecord
  belongs_to :estado
  has_many :asentamientos, dependent: :destroy
end
