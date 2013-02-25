class MailingAddress < ActiveRecord::Base
  attr_accessible :city, :line1, :line2, :name, :state_id, :zip
  
  belongs_to :cs_application
end
