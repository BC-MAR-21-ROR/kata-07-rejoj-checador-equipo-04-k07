# frozen_string_literal: true

ActiveAdmin.register_page 'Absence Report' do
  content do
    year = (params[:year] || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i
    active_admin_form_for '', url: admin_absence_report_path, method: 'get', decorate: true do |f|
      panel 'Selected month' do
        Date.new(year, month).strftime('%B, %Y').to_s
      end

      f.inputs "Select month and year below..." do
        f.input :year, type: 'select', collection: 2020..2050, selected: year
        f.input :month, type: 'select', collection: 1..12, name: 'month', selected: month
        f.button 'Send'
      end
    end

    table_for Employee.absences_month(year, month), { class: 'index_table' } do
      column :day
      column(:employee_number) { |absence| absence[:employee].employee_number }
      column(:employee)
      column(:private_number) { |absence| absence[:employee].private_number }
      column(:email) { |absence| absence[:employee].email }
      column(:company_branch) { |absence| absence[:employee].company_branch }
    end
  end
end
