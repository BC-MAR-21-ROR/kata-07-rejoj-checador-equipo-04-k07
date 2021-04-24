ActiveAdmin.register Employee do

  permit_params :email, :name, :position, :employee_number, :status, :company_branch_id, :private_number
end
