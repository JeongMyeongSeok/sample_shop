class Product < ActiveRecord::Base
  has_many :cart_details, foreign_key: "product_id", dependent: :destroy
  has_many :users, through: :cart_details, source: :user
end
