# frozen_string_literal: true

ActiveAdmin.register_page 'Attendance Report' do
  content do
    day = (params[:day] || Date.today.strftime('%Y-%m-%d'))
    active_admin_form_for '', url: admin_attendance_report_path, method: 'get', decorate: true do |f|
      panel 'Selected day' do
        day
      end

      f.inputs 'Select a day below' do
        f.input :day, as: :datepicker,
                      datepicker_options: {
                        min_date: '2013-10-8',
                        max_date: '+3D',
                        default_date: day
                      }, input_html: {
                        autocomplete: 'off',
                        value: day
                      }
        f.button 'Send'
      end
    end
    panel 'Attendance by day' do
      collection = Employee.attendances(day).page(params[:page]).per(30)
      paginated_collection(collection, download_links: false) do
        table_for(collection) do
          column :day
          column(:check_type) { |employee| employee.check_type.zero? ? 'in' : 'out' }
          column(:time) { |employee| employee.time.to_datetime.in_time_zone }
          column :employee_number
          column :name
          column :private_number
          column :email
        end
      end
    end
  end
  page_action :import_csv, method: :get do
    day = (params[:day] || Date.today.strftime('%Y-%m-%d'))
    employees = Employee.attendances(day)
    csv = CSV.generate(encoding: 'UTF-8') do |csv_file|
      csv_file << ['Day', 'Check type', 'Time', 'Employee Number', 'Name', 'Private Number', 'Email']
      employees.each do |u|
        check_type = u.check_type.zero? ? 'in' : 'out'
        time = u.time.to_datetime.in_time_zone
        csv_file << [u.day, check_type, time, u.employee_number, u.name, u.private_number, u.email]
      end
    end
    send_data csv.encode('UTF-8'), type: 'text/csv; charset=UTF-8; header=present',
                                   disposition: 'attachment; filename=attendance_report.csv'
  end

  action_item :add do
    link_to 'Export to CSV', admin_attendance_report_import_csv_path(day: params[:day]),
            method: :get
  end
end
