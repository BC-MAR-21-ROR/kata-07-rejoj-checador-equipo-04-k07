# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require 'csv'

puts "Importing companyBranches..."
CSV.foreach(Rails.root.join("db/seeds/companyBranches.csv"), headers: true) do |row|
  CompanyBranch.create! do |company_branch|
    company_branch.id = row[0]
    company_branch.name = row[1]
    company_branch.address = row[2]
  end
end

puts "Importing employees..."
CSV.foreach(Rails.root.join("db/seeds/employees.csv"), headers: true) do |row|
  Employee.create! do |employee|
    employee.id = row[0]
    employee.email = row[1]
    employee.name = row[2]
    employee.position = row[3]
    employee.employee_number = row[4]
    employee.status = row[5]
    employee.company_branch_id = row[6]
    employee.private_number = row[7]
  end
end