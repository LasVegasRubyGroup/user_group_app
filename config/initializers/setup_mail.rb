require 'tlsmail'    
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,  
  :address            => 'smtp.gmail.com',
  :port               => 587,
  :domain             => 'gmail.com', #you can also use google.com
  :authentication     => "plain",
  :user_name          => ENV['TOPICS_EMAIL_USERNAME'],
  :password           => ENV['TOPICS_EMAIL_PASSWORD'] 
}
