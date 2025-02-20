class Constancia < ApplicationRecord
  self.table_name = 'constancias'
  belongs_to :user
  belongs_to :vehiculo, optional: true
end