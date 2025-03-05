class Estado < ApplicationRecord
  has_many :municipios, dependent: :destroy
end
