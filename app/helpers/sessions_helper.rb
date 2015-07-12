module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))#DB column remember_token
    self.current_user = user
  end
  def signed_in? #for check
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil #current_user method名前変えたら、エラーになる
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end
  def current_user #current_useraに変えたら !current_user.nil?エラー
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user # 同じ結果 @current_user also self.current_user
  end

  def signed_in_user
    unless signed_in? #if you not login
      store_location
      flash[:notice] = "Please sign in.."
      redirect_to signin_url #redirect_to signin_path同じ
    end
  end
  
  def redirect_back_or_default
    redirect_to(session[:return_to] || root_url) #or default
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end