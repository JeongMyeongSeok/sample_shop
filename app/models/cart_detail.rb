class CartDetail < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  default_scope -> { order('created_at DESC') }
  VALID_QUANTITY_REGEX = /\A[1-9]\z/
  validates :quantity, presence: true, format: { with: VALID_QUANTITY_REGEX }
end
