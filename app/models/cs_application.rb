class CsApplication < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :middle_name, :towson_id_number,:is_citizen, :phone, :user_id

  belongs_to :user
  has_one :purpose_statement, :foreign_key => 'cs_application_id', :class_name => 'PurposeStatement', :dependent => :destroy
  has_many :recommendations, :dependent => :destroy
  has_one :mailing_address, :dependent => :destroy
  has_many :institutions, :dependent => :destroy
  has_many :transcripts, :dependent => :destroy

  accepts_nested_attributes_for :recommendations

  validates :first_name, :last_name, :towson_id_number, :phone, presence: true
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :towson_id_number, uniqueness: true, on: :create
  validates :first_name, :last_name,length: { in: 2..50 }
  validates :towson_id_number, length: { within: 6..7 }
  validates :phone, length: { is: 10 }
  validates :towson_id_number,:phone, numericality: { only_integer: true }
  #validates :email, email_format: true
  validates :is_citizen, :acceptance => {:accept => true, message: "This application requires applicants to be a US citizen." }

  STATUS_STARTED = "STARTED"
  STATUS_SUBMITTED = "SUBMITTED"
  STATUS_REVIEWED = "REVIEWED"
  STATUS_DENIED = "DENIED"
  STATUS_APPROVED = "APPROVED"

end
