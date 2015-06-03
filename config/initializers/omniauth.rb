# Rails.application.config.middleware.use OmniAuth::Builder do
#   	provider :facebook, '1593949210874542', '13d91b6cb1f3b82389241cf56e6d8db7', { :scope => 'user_location, user_birthday, user_about_me, email' }
# end

Rails.application.config.middleware.use OmniAuth::Builder do
   	provider :facebook, '1596716730597790', 'a31ce4054db243ddb9d7c866a6a7b948', { :scope => 'user_location, user_birthday, user_about_me, email' }
end


