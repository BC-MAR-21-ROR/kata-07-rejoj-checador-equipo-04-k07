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
    absences = []
    Employee.all.each do |employee|
      (Date.new(year, month)..Date.new(year, month, -1)).to_a.each do |day|
        absences << { day: day, employee: employee } if employee.absence?(day)
      end
    end
    absences
  end

  def absence?(day)
    return false unless day <= Date.today

    true unless EmployeeCheck.where(employee_id: id, created_at: day.midnight..day.end_of_day).count.positive?
  end
end
