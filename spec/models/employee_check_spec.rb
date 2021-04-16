require 'rails_helper'

RSpec.describe EmployeeCheck, type: :model do
  fixtures :employees
  context 'validation tests' do
    it 'has presence validation in private number' do
      employee_check = described_class.new
      employee_check.save

      expect(employee_check.errors.include?(:private_number)).to eq true
    end

    it 'has existence employee validation' do
      employee_check = described_class.new(private_number: '321') # private number does not exist
      employee_check.save

      expect(employee_check.errors.include?(:employee)).to eq true
    end

    it 'is saved when a correct employee private number is given' do
      employee_check = described_class.new(private_number: employees(:one).private_number).save

      expect(employee_check).to eq true
    end
  end

  context 'correct check_type when register' do
    let(:employee_check) { described_class.new(private_number: employees(:one).private_number) }

    it 'is a check in when there is no records' do
      employee_check.save
      expect(employee_check.check_type).to eq 'check_in'
    end

    it 'is a check out when there are a previous check in' do
      employee_check.save
      employee_check_two = described_class.new(private_number: employees(:one).private_number)
      employee_check_two.save
      expect(employee_check_two.check_type).to eq 'check_out'
    end
  end
end
