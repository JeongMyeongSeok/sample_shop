class OrdersController < ApplicationController
  def address
    @address = current_user.commonly_used_destinations.build
    @address_list = CommonlyUsedDestination.where("user_id = ?", current_user.id)
  end
end
