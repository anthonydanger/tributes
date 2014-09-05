module ApplicationHelper
	def facebook_user?
  	provider != nil && uid != nil
	end
end
