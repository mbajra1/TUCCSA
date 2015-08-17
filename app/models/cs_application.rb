class CsApplication < ActiveRecord::Base
  attr_accessible :email, :first, :last, :middle, :tuid, :user_id
  
  belongs_to :user
  has_many :recommendations
  has_one :mailing_address
  has_many :institutions
  has_many :transcripts, :dependent => :destroy
  
  has_attached_file :purpose
  accepts_nested_attributes_for :recommendations

  validates_attachment_content_type :purpose, :content_type => %w(application/msword)
  
  STATUS_STARTED = 0
  STATUS_SUBMITTED = 1
  STATUS_REVIEWED = 2
  STATUS_DENIED = 3
  STATUS_APPROVED = 4
  
  
end
