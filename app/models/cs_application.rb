class CsApplication < ActiveRecord::Base
  attr_accessible :email, :first, :last, :middle, :tuid, :user_id
  
  belongs_to :user
  has_many :recommendations
  has_one :mailing_address
  has_many :institutions
  
end
