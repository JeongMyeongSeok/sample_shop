class CartDetailsController < ApplicationController
  before_action :signed_in_user, only: [:show]
  before_action :check_stock, only: [:create, :update]

  def show
    @cart_details = check_current_cart_by_current_user
  end

  def create
    selected_product = Product.find_by("id = ?", params[:cart_detail][:product_id])
    selected_quantity = product_quantity
    if current_user.add_product_to_cart(current_user, selected_product, selected_quantity)
      redirect_to cart_detail_path(current_user)
    else
      flash[:error] = "カートに商品を10個以上入れるのはできません"
      redirect_to product_path(selected_product)
    end
  end

  def destroy
    product_in_the_cart = selected_product_in_the_cart
    product_in_the_cart.destroy
    redirect_to cart_detail_path(current_user)
  end

  def update
    product_in_the_cart = selected_product_in_the_cart
    if product_in_the_cart.update_attributes(quantity_param)
      selected_quantity = product_quantity
      current_user.update_product_in_cart(product_in_the_cart, selected_quantity)
      redirect_to cart_detail_path(current_user)
    else
      redirect_to cart_detail_path(current_user)
    end
  end

  private
  def check_stock
    
  end

  def selected_product_in_the_cart
    CartDetail.find_by("id = ?", params[:id])
  end

  def quantity_param
    params.require(:cart_detail).permit(:quantity)
  end

  def product_quantity
    params[:cart_detail][:quantity]
  end
end
