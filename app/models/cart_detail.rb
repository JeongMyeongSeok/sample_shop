class CartDetail < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :quantity, presence: true, inclusion: { in: 1..9 }
end
