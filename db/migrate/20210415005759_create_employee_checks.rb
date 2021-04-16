class CreateEmployeeChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_checks do |t|
      t.integer :check_type
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
