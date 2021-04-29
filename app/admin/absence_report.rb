# frozen_string_literal: true

ActiveAdmin.register_page 'Absence Report' do
  content do
    year = (params[:year] || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i
    active_admin_form_for '', url: admin_absence_report_path, method: 'get', decorate: true do |f|
      panel 'Selected month' do
        Date.new(year, month).strftime('%B, %Y').to_s
      end

      f.inputs 'Select month and year below...' do
        f.input :year, type: 'select', collection: 2020..2050, selected: year
        f.input :month, type: 'select', collection: 1..12, name: 'month', selected: month
        f.button 'Send'
      end
    end
    panel 'Absences Table' do
      collection = Kaminari.paginate_array(Employee.absences_month(year, month)).page(params[:page]).per(30)
      paginated_collection(collection, download_links: false) do
        table_for(collection) do
          column :day
          column :employee_number
          column :name
          column :private_number
          column :email
        end
      end
    end
  end
  page_action :import_csv, method: :get do
    year = (params[:year] || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i
    employees = Employee.absences_month(year, month)
    csv = CSV.generate(encoding: 'UTF-8') do |csv_file|
      csv_file << ['Day', 'Employee Number', 'Name', 'Private Number', 'Email']
      employees.each do |u|
        csv_file << [u.day, u.employee_number, u.name, u.private_number, u.email]
      end
    end
    send_data csv.encode('UTF-8'), type: 'text/csv; charset=UTF-8; header=present',
                                   disposition: 'attachment; filename=absence_report.csv'
  end

  action_item :add do
    link_to 'Export to CSV', admin_absence_report_import_csv_path(year: params[:year], month: params[:month]),
            method: :get
  end
end
