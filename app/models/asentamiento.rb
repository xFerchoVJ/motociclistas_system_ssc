class Asentamiento < ApplicationRecord
  belongs_to :municipio
  has_many :codigos_postales, class_name: "CodigoPostal", dependent: :destroy
end
