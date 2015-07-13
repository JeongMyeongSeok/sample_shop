class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_details, foreign_key: "order_id", dependent: :destroy
  has_many :products, through: :order_details, source: :product
end
