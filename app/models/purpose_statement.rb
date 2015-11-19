class PurposeStatement < ActiveRecord::Base
 attr_accessible :cs_application_id, :purpose

  belongs_to :cs_application

  has_attached_file :purpose
  validates_attachment_content_type :purpose, content_type: ['application/pdf']
  #validates_attachment_presence :purpose
  #validates_attachment_content_type :purpose, content_type: [ 'application/msword']
  #validates_attachment :purpose, :content_type => {:content_type => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' }
  #validates_attachment_content_type :purpose, :content_type => [ 'application/force-download' ]
  #validates_attachment_content_type :purpose, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  attr_accessor :form_step

  validates :purpose, presence: { message: "File must be selected" }, if: -> {required_for_step?(:purpose_statement)}

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
