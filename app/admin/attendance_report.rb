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
          column(:check_type) { |type| type.check_type.zero? ? 'in' : 'out' }
          column :time
          column :employee_number
          column :name
          column :private_number
          column :email
        end
      end
    end
  end
end
