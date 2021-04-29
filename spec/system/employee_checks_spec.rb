require 'rails_helper'

RSpec.describe 'EmployeeChecks', type: :system do
  fixtures :employees
  before do
    driven_by(:rack_test)
  end

  context 'has elements in the page' do
    it 'shows a private number field' do
      visit '/'

      expect(page).to have_field('employee_check_private_number')
    end
  end

  context 'correct messages in employee check' do
    it 'shows error messages when no private number is given' do
      visit '/'

      fill_in 'employee_check_private_number', with: ''
      click_button 'Check'

      expect(page).to have_text('error')
    end

    it 'shows error messages when an inexistent private number is given' do
      visit '/'

      fill_in 'employee_check_private_number', with: '656'
      click_button 'Check'

      expect(page).to have_text('error')
    end

    it 'shows success message when a correct private number is given' do
      visit '/'

      fill_in 'employee_check_private_number', with: employees(:one).private_number
      click_button 'Check'

      expect(page).to have_text('stored correctly')
    end
  end
end
