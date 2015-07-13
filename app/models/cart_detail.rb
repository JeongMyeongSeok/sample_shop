class CartDetail < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  default_scope -> { order('created_at DESC') }
  validates :quantity, presence: true, inclusion: { in: 1..9 }
end
