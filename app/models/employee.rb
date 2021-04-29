# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                :bigint           not null, primary key
#  email             :string
#  name              :string
#  position          :string
#  employee_number   :integer
#  status            :boolean          default(TRUE)
#  company_branch_id :bigint           not null
#  private_number    :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Employee < ApplicationRecord
  belongs_to :company_branch
  has_many :employee_checks

  validates :email, :employee_number, :private_number, presence: true, uniqueness: true
  validates :company_branch, presence: true

  # override destroy action
  def destroy
    update(status: (status ? false : true))
  end

  def self.absences_month(year = Date.today.year, month = Date.today.month)
    employees = []
    date_init = "#{year}-#{month}-01".to_date
    (date_init.beginning_of_month..date_init.end_of_month).to_a.each do |day|
      employees += absences(day)
    end
    employees
  end

  def self.absences(day)
    select('employees.*', "'#{day}' as day")
      .joins("LEFT JOIN employee_checks ON employees.id = employee_checks.employee_id AND
      Date(employee_checks.created_at) = '#{day}'").having('COUNT(employee_checks.id) = ?', 0).group('employees.id')
  end

  def absence?(day)
    return false unless day <= Date.today

    true unless EmployeeCheck.where(employee_id: id, created_at: day.midnight..day.end_of_day).count.positive?
  end
end
