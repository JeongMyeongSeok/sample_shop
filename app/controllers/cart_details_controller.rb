class CartDetailsController < ApplicationController
  before_action :signed_in_user, only: [:index, :create, :destroy, :update]
  before_action :check_stock, only: [:create]

  def index
    @cart_details = check_current_cart_by_current_user
  end

  def create
    selected_product = Product.find_by("id = ?", params[:cart_detail][:product_id])
    selected_quantity = product_quantity
    if current_user.add_product_to_cart(selected_product, selected_quantity)
      redirect_to cart_details_path
    else
      flash[:error] = "カートに商品を10個以上入れるのはできません"
      redirect_to cart_details_path
    end
  end

  def destroy
    product_in_the_cart = CartDetail.find_by("id = ?", params[:id])
    if product_in_the_cart.nil?
      flash[:error] = "すでに商品は削除されました"
      redirect_to cart_details_path
    else
      product_in_the_cart.destroy
      flash[:success] = "正常に削除されました"
      redirect_to cart_details_path
    end
  end

  def update
    product_in_the_cart = CartDetail.find_by("id = ?", params[:id])
    if !product_in_the_cart.nil? 
      product_in_the_cart.update_attributes(quantity_param)
      selected_quantity = product_quantity
      current_user.update_product_in_cart(product_in_the_cart, selected_quantity)
      flash[:success] = "正常に変更されました"
      redirect_to cart_details_path
    else
      flash[:error] = "すでに商品は削除されました"
      redirect_to cart_details_path
    end
  end

  private
  
  def check_stock
    product = Product.find_by("id = ?", params[:cart_detail][:product_id])
    cart_product = CartDetail.find_by(user_id: current_user.id, product_id: product.id)
    if !cart_product.nil? && (cart_product.quantity.to_i + product_quantity.to_i > product.stock)
      flash[:error] = "在庫(#{product.stock}) | カートにある該当商品の数 (#{cart_product.quantity})"
      redirect_to product_path(product)
    end
  end

  def quantity_param
    params.require(:cart_detail).permit(:quantity)
  end

  def product_quantity
    params[:cart_detail][:quantity]
  end
end
