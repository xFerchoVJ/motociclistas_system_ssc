class AddTypePersonFieldToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :tipo_persona, :string, null: false,  default: 'fisica' # 'fisica' or 'moral'
    add_column :users, :rfc, :string
    add_column :users, :domicilio, :text
    add_column :users, :representante_legal, :string
  end
end
