# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TUCCSA2::Application.initialize!

#for mailer
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address => 'smtpout.secureserver.net',
  :domain  => 'www.iandrobot.net',
  :port      => 80,
  :user_name => 'tucs@iandrobot.net',
  :password => 'TowsonCS',
  :authentication => :plain
}