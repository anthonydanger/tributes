class SessionsController < ApplicationController
	def new
	end

  def create
  	if params[:session]
  		user = User.find_by(email: params[:session][:email].downcase)
			if user && user.authenticate(params[:session][:password])
				sign_in user
				redirect_back_or user
			else
				flash[:error] = 'Invalid email/password combination'
				render 'new'
			end

  	else
	  	user = User.from_omniauth(env["omniauth.auth"])
	  	sign_in user
	  	redirect_back_or user
  	end
  end

  def destroy
  	session.delete(:user_id)
  	@current_user = nil
  	redirect_to root_url
  end
end
