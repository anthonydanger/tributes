OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], 

  	{
  		:secure_image_url => 'true',
  		:scope => 'read_friendlists,user_friends'
  	}

end