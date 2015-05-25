Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, '1593949210874542', '13d91b6cb1f3b82389241cf56e6d8db7', { :scope => 'user_location, user_birthday, user_about_me', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'} }}
end

