class CartDetailsController < ApplicationController
  before_action :signed_in_user, only: [:index, :create, :destroy, :update]
  before_action :check_stock_create, only: [:create]
  before_action :check_stock_update, only: [:update]
  before_action :check_price, only: [:index]

  def index
    @cart_details = get_current_cart_by_current_user
  end

  def create
    selected_product = Product.find_by("id = ?", params[:cart_detail][:product_id])
    selected_quantity = selected_quantity_params
    if current_user.add_product_to_cart(selected_product, selected_quantity)
      redirect_to cart_details_path
    else
      flash[:error] = "カートには一つの商品にあたり最大9個入れることができます"
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
      product_in_the_cart.update_attributes(quantity_params)
      selected_quantity = selected_quantity_params
      current_user.update_product_in_cart(product_in_the_cart, selected_quantity)
      flash[:success] = "正常に変更されました"
      redirect_to cart_details_path
    else
      flash[:error] = "すでに商品は削除されました"
      redirect_to cart_details_path
    end
  end

  private

  def check_price
    cart_details = get_current_cart_by_current_user
    cart_details.each do |cart_detail|
      price_per_one = (cart_detail.price / cart_detail.quantity)
      if price_per_one != cart_detail.product.price
        price_per_quantity = cart_detail.product.price * cart_detail.quantity
        context = "#{cart_detail.product.name}の値段が変更されました.
                   #{price_per_one}円 -> #{cart_detail.product.price}円"
        flash.now[:notice] = "#{context}"
        cart_detail.update_attribute(:price, price_per_quantity)
      end
    end
  end
    
  def check_stock_create
    product = Product.find_by("id = ?", params[:cart_detail][:product_id])
    cart_detail = CartDetail.find_by(user_id: current_user.id, product_id: product.id)
    if cart_detail.nil?
      if selected_quantity_params.to_i > product.stock
        flash[:error] = "在庫不足"
        redirect_to product_path(product)
      end
    else
      if(cart_detail.quantity.to_i + selected_quantity_params.to_i) > product.stock 
        flash[:error] = "在庫不足"
        redirect_to product_path(product)
      end
    end
  end

  def check_stock_update
    product = Product.find_by("id = ?", params[:cart_detail][:product_id])
    if selected_quantity_params.to_i > product.stock
      flash[:error] = "在庫不足"
      redirect_to product_path(product)
    end
  end

  def quantity_params
    params.require(:cart_detail).permit(:quantity)
  end

  def selected_quantity_params
    params[:cart_detail][:quantity]
  end
end
