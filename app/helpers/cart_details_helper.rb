module CartDetailsHelper
  def check_current_cart_by_current_user
    CartDetail.where("user_id = ?", current_user.id)
  end
  def synchronization_product_price(cart_product)
    if cart_product.price != ( cart_product.product.price / cart_product.quantity )
      price = cart_product.product.price * cart_product.quantity
      cart_product.update( price: price )
      return price
    else
      cart_product.price
    end
  end
end
