module SessionsHelper

  def sign_in(user)
  	session[:user_id] = user.id
  end

  def signed_in?
  	!current_user.nil?
  end

  def current_user?(user)
  	user == current_user
  end

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
  	redirect_to(session[:forwarding_url] || default)
  	session.delete(:forwarding_url)
  end

  def store_location
  	session[:forwarding_url] = request.url if request.get?
  end
end