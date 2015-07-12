class CartDetailsController < ApplicationController
  def show
    @cart_details = CartDetail.where("user_id = ?", current_user.id)
  end

  def create
    selected_product = Product.find(params[:cart_detail][:product_id])
    selected_quantity = product_quantity
    if current_user.add_product_to_cart(current_user, selected_product, selected_quantity)
      redirect_to cart_detail_path(current_user)
    else
      flash[:error] = "商品を10個"
      redirect_to product_path(selected_product)
    end
  end

  def destroy
    product_destroy = CartDetail.find_by(id: params[:id])
    product_destroy.destroy
    redirect_to cart_detail_path(current_user)
  end

  def update
    cart_detail = CartDetail.find_by(id: params[:id])
    if cart_detail.update_attributes(quantity_param)
      selected_quantity = product_quantity
      current_user.minus_product_in_cart(cart_detail, selected_quantity)
      redirect_to cart_detail_path(current_user)
    else
      redirect_to cart_detail_path(current_user)
    end
  end

  private

  def quantity_param
    params.require(:cart_detail).permit(:quantity)
  end

  def product_quantity
    params[:cart_detail][:quantity]
  end
end
