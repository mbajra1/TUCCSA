class PurposeStatement < ActiveRecord::Base
  attr_accessible :purpose

  attr_accessor :form_step
  belongs_to :cs_application

  has_attached_file :purpose
  validates_attachment_content_type :purpose, content_type: ['application/pdf']
  validates :purpose, presence: { message: "File must be selected" }, if: -> {required_for_step?(:purpose_statement)}

  #validates_attachment_content_type :purpose, content_type: [ 'application/msword']
  #validates_attachment :purpose, :content_type => {:content_type => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' }

  # Force step form to validate before it renders the next page.
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
