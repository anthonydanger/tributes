module SessionsHelper

  def sign_in(user)
  	session[:user_id] = user.id
  end

  def signed_in?
  	!current_user.nil?
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
end