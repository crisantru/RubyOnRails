class Bill < ActiveRecord::Base
  has_many :articles_bills
  belongs_to :clients
  belongs_to :branches
end
