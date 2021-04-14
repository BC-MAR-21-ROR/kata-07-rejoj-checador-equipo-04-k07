class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :email
      t.string :name
      t.string :position
      t.integer :employee_number
      t.boolean :status, default: true
      t.references :company_branch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
