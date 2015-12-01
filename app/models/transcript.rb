class Transcript < ActiveRecord::Base
  attr_accessible :document

  belongs_to :cs_application
  attr_accessor :form_step

  has_attached_file :document
  validates_attachment_content_type :document, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
  validates :document, presence: {message: "File must be selected" }, if: -> {required_for_step?(:transcript)}

  # Force step form to validate before it renders the next page.
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
