# == Schema Information
#
# Table name: employees
#
#  id                :bigint           not null, primary key
#  email             :string
#  name              :string
#  position          :string
#  employee_number   :integer
#  status            :boolean          default(TRUE)
#  company_branch_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Employee < ApplicationRecord
  belongs_to :company_branch
end
