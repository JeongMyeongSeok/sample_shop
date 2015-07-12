class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by("email = ? ", params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ようこそ"
      sign_in user
      redirect_back_or_default
      #redirect_back_or user
    else
      flash.now[:error] = '有効ではない email あるいは password '
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end

