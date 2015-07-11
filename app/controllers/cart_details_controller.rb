class CartDetailsController < ApplicationController
  def show
    @cart_details = CartDetail.where("user_id = ?", current_user.id)
  end

  def create
    selected_product = Product.find_by(selected_product)
    selected_quantity = product_quantity
    current_user.add_product_to_cart(current_user, selected_product, selected_quantity)
    redirect_to cart_detail_path(current_user)
  end

  private
  def selected_product
    params[:cart_detail][:Product_id]
  end

  def product_quantity
    params[:cart_detail][:quantity]
  end
end