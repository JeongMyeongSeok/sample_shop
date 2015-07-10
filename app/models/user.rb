class User < ActiveRecord::Base

  has_many :cart_details, foreign_key: "user_id", dependent: :destroy
  has_many :products, through: :cart_details, source: :product

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

  def get_product(current_user, product, quantity, price)
    cart_product = cart_details.find_by(user_id: current_user.id, product_id: product.id)
    if cart_product
      all_price = cart_product.price.to_i + price.to_i
      all_quantity = cart_product.quantity.to_i + quantity.to_i
      cart_product.update(price: all_price)
      cart_product.update(quantity: all_quantity)
    else
      cart_details.create!(product_id: product.id, quantity: quantity, price: price)
    end
  end
  
  private


  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token) #User.remember_token
  end
end