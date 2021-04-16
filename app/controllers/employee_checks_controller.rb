class EmployeeChecksController < ApplicationController
  def create
    @employee_check = EmployeeCheck.new(employee_check_params)

    respond_to do |format|
      if @employee_check.save
        format.html do
          redirect_to root_path,
                      notice: "#{@employee_check.check_type} stored correctly for #{@employee_check.employee.name} at #{@employee_check.created_at}."
        end
        format.json { head :no_content }
      else
        format.html { render '/home/index', status: :unprocessable_entity }
        format.json { render json: @employee_check.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def employee_check_params
    params.require(:employee_check).permit(:check_type, :employee, :private_number)
  end
end
