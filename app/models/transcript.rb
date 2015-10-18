class Transcript < ActiveRecord::Base
  #attr_accessible :cs_application_id, :document

  belongs_to :cs_application
  has_attached_file :document
  validates_attachment_content_type :document, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']

  attr_accessor :form_step

  validates :document, presence: {message: "File must be selected" }, if: -> {required_for_step?(:transcript)}

  def required_for_step?(step)
    # All fields are required if no form step is present
    puts step.to_s
    puts form_step
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
