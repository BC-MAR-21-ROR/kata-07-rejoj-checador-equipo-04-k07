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
#  private_number    :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Employee < ApplicationRecord
  belongs_to :company_branch
  has_many :employee_checks

  validates :email, :employee_number, :private_number, presence: true, uniqueness: true
  validates :company_branch, presence: true

  # override destroy action
  def destroy
    update(status: (status ? false : true))
  end
end
