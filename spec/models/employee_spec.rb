require 'rails_helper'

RSpec.describe Employee, type: :model do
  fixtures :employees
  context 'absences report' do
    it 'return employee in absences list when there is no check in' do
      absences_list = described_class.absences(Date.today)

      employee = absences_list.find_by(employee_number: employees(:one).employee_number)
      expect(employee).not_to eq nil
    end

    it 'does not return employee in absences list when there is a check in' do
      EmployeeCheck.create(private_number: employees(:one).private_number)
      absences_list = described_class.absences(Date.today)

      employee = absences_list.find_by(employee_number: employees(:one).employee_number)
      expect(employee).to eq nil
    end
  end

  context 'attendances report' do
    it 'return employee in attendances list when there is a check in given day' do
      EmployeeCheck.create(private_number: employees(:one).private_number)
      attendances_list = described_class.attendances(Date.today)

      employee = attendances_list.find_by(employee_number: employees(:one).employee_number)
      expect(employee).not_to eq nil
    end

    it 'does not return employee in attendances list when there is not a check in given day' do
      attendances_list = described_class.attendances(Date.today)

      employee = attendances_list.find_by(employee_number: employees(:one).employee_number)
      expect(employee).to eq nil
    end
  end
end
