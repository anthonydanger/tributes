OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1517252721839426', 'df0d5cd8579a71914ac58013efe43ea6', 

  	{
  		:secure_image_url => 'true',
  		:scope => 'read_friendlists,user_friends'
  	}

end