class CommonlyUsedDestinationsController < ApplicationController
  def create
    @address = CommonlyUsedDestination.new(address_params)
    if @address.save
      flash[:success] = "新しい住所登録されました"
      redirect_to address_order_path(current_user)
    else
      flash[:error] = "error"
      redirect_to address_order_path(current_user)
    end
  end

  private

  def address_params
    params.require(:commonly_used_destination).permit(:user_id, :name, :address, :phone)
  end
end
