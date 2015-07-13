class OrdersController < ApplicationController

  def address
    @address = current_user.commonly_used_destinations.build
    @address_list = CommonlyUsedDestination.where("user_id = ?", current_user.id)
  end

  def confirm
    @address = CommonlyUsedDestination.find_by("id = ?", params[:id])
    @products_in_cart = CartDetail.where("user_id = ?", current_user.id)
    if @address.nil? || @address.user_id != current_user.id
      redirect_to root_url
    end
  end
end
