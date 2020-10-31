class Purchase < ApplicationRecord
  belongs_to :good
  has_one :purchases_info
  belongs_to :user
end
