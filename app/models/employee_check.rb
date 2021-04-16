# frozen_string_literal: true

class EmployeeCheck < ApplicationRecord
  belongs_to :employee, optional: true
  attr_accessor :private_number

  enum check_type: %i[check_in check_out]

  validates :private_number, presence: true
  validate :employee_existence
  before_create :fill_info

  private

  def employee_existence
    return if Employee.find_by(private_number: private_number)

    errors.add 'employee', "private number #{private_number} not found."
  end

  def fill_info
    self.employee = Employee.find_by(private_number: private_number)
    self.check_type = decide_type
  end

  def decide_type
    last_employee_check = employee.employee_checks.last
    return :check_in unless last_employee_check

    last_employee_check.check_type == 'check_in' ? :check_out : :check_in
  end
end
