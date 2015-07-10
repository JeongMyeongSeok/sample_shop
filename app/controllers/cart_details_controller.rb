class CartDetailsController < ApplicationController
  def show
    @cart_detail = CartDetail.find_by(id: params[:id])
  end

  def create
    product = Product.find(params[:cart_detail][:product_id])
    quantity = params[:cart_detail][:quantity]
    price = quantity.to_i * product.price
    current_user.get_product(current_user, product, quantity, price)
    redirect_to cart_detail_path(current_user)
  end
end