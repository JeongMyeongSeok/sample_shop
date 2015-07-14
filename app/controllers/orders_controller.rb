class OrdersController < ApplicationController
  before_action :check_stock, only: [:address, :confirm]

  def address
    @address = current_user.commonly_used_destinations.build
    @address_list = CommonlyUsedDestination.where("user_id = ?", current_user.id)
  end

  def confirm
    @address = CommonlyUsedDestination.find_by("id = ?", params[:id])
    @products_in_cart = CartDetail.where("user_id = ?", current_user.id)
    if @address.nil? || @address.user_id != current_user.id
      redirect_to address_order_path(current_user)
    end
  end

  private

  def check_stock
    cart_details = current_user.cart_details
    cart_details.each do |cart_detail|
      if cart_detail.quantity > cart_detail.product.stock
        flash[:error] = "在庫不足"
        redirect_to cart_details_path
      end
    end
  end
end
