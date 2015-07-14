module CartDetailsHelper
  
  def check_current_cart_by_current_user
    CartDetail.where("user_id = ?", current_user.id)
  end 
end
