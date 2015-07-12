class CartDetail < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, inclusion: { in: 1..10 }
end
