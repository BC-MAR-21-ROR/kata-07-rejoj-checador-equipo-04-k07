# == Schema Information
#
# Table name: company_branches
#
#  id         :bigint           not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CompanyBranch < ApplicationRecord
  has_many :employees

  validates :name, presence: true, uniqueness: true
end
