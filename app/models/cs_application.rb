class CsApplication < ActiveRecord::Base
  attr_accessible :email, :first, :last, :middle, :tuid, :user_id
  
  belongs_to :user
  
end
