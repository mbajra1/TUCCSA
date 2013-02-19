class Institution < ActiveRecord::Base
  attr_accessible :attended_from, :attended_to, :city, :degree, :institution, :state_id
end
