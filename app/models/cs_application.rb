class CsApplication < ActiveRecord::Base
  attr_accessible :email, :first, :last, :middle, :tuid,:is_citizen, :telephone, :user_id

  belongs_to :user
  has_many :recommendations
  has_one :mailing_address
  has_many :institutions
  has_many :transcripts, :dependent => :destroy

  attr_accessor :form_step

  has_attached_file :purpose
  validates_attachment_content_type :purpose, content_type: ['application/pdf']
  #validates_attachment_content_type :purpose, content_type: [ 'application/msword']
  #validates_attachment :purpose, :content_type => { :content_type => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' }
  #validates_attachment_content_type :purpose, :content_type => [ 'application/force-download' ]
  #validates_attachment_content_type :purpose, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  accepts_nested_attributes_for :recommendations

  validates :email, :first, :last, :tuid, :telephone, presence: true
  validates :email,:tuid, uniqueness: true
  validates :first, length: { in: 2..50 }
  validates :last, length: { in: 2..50 }
  validates :tuid, length: { within:6.. 7 }
  validates :telephone, length: { is: 10 }
  validates :tuid, numericality: { only_integer: true }
  validates :email, email_format: true

  #with_options :if => :content? do |driver|
   validates :purpose, presence: true, if: -> {required_for_step?(:purpose)}
  #end

  def driver?
    roles.any? { |role| role.name == "driver" }
  end

  STATUS_STARTED = 0
  STATUS_SUBMITTED = 1
  STATUS_REVIEWED = 2
  STATUS_DENIED = 3
  STATUS_APPROVED = 4

  def required_for_step?(step)
    # All fields are required if no form step is present
    # puts form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

  def content?

    return true if form_step =="purpose"

  end

end
