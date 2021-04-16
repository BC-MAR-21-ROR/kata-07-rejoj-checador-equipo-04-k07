class AddPrivateNumberToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :private_number, :string
  end
end
