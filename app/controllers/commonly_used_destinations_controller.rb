class CommonlyUsedDestinationsController < ApplicationController
  before_action :selected_address_for_edit, only: [:edit, :update, :destroy]

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

  def destroy
    if @address.destroy
      flash[:success] = "削除されました"
      redirect_to address_order_path(current_user)
    else
      flash[:error] = "error"
      redirect_to address_order_path(current_user)
    end
  end

  def edit
  end

  def update
    if @address.update_attributes(edit_address_params)
      flash[:success] = "住所変更"
      redirect_to address_order_path(current_user)
    else
      render "edit"
    end
  end

  private

  def selected_address_for_edit
    @address = CommonlyUsedDestination.find_by(id: params[:id], user_id: current_user.id)
    if @address.nil?
      redirect_to root_url
    end
  end

  def edit_address_params
    params.require(:commonly_used_destination).permit(:name, :address, :phone)
  end

  def address_params
    params.require(:commonly_used_destination).permit(:user_id, :name, :address, :phone)
  end
end
