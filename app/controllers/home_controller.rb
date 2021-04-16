class HomeController < ApplicationController
  def index
    @employee_check = EmployeeCheck.new
  end
end
