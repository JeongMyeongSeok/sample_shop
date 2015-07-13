class User < ActiveRecord::Base
  has_many :cart_details, foreign_key: "user_id", dependent: :destroy
  has_many :products, through: :cart_details, source: :product

  has_many :commonly_used_destinations, foreign_key: "user_id", dependent: :destroy

  has_many :orders, foreign_key: "user_id", dependent: :destroy
  
  #has_many :cart_details, foreign_key: "user_id", dependent: :destroy
  #has_many :products, through: :cart_details, source: :product

  before_save { self.email = email.downcase } #self.email
  before_create :create_remember_token

  VALID_NAME_REGEX = /\A\w+\z/
  validates :name, presence: true, length: { maximum: 50 }, 
                   format: { with: VALID_NAME_REGEX }, 
                   uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def add_product_to_cart(user, product, quantity)
    specified_product = CartDetail.find_by(user_id: user.id, product_id: product.id)
    price_per_quantity = product.price * quantity.to_i
    if specified_product
      all_price = (specified_product.price + price_per_quantity)
      all_quantity = (specified_product.quantity + quantity.to_i)
      specified_product.update(price: all_price, quantity: all_quantity)
    else
      cart_details.create(product_id: product.id, quantity: quantity, price: price_per_quantity)
    end
  end

  def minus_product_in_cart(cart_detail, quantity)
    #cart_product = CartDetail.find_by(id: params[:id])
    all_price = (cart_detail.product.price * quantity.to_i)
    cart_detail.update(price: all_price)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token) #User.remember_token
  end
end
