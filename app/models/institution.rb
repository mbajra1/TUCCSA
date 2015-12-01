class Institution < ActiveRecord::Base
  attr_accessible :attended_from, :attended_to, :city, :degree, :institution, :state_id

  attr_accessor :form_step  # access form step
  belongs_to :cs_application
  belongs_to :state

  validates :attended_from, :attended_to, :city, :degree, :institution, presence: true, if: -> {required_for_step?(:educational)}
  validates :state_id, presence: { message: "state must be selected" }
  validates :city, :degree, :institution, format: { with: /\A[a-zA-Z\s]*\z/, message: "only allows letters" }, if: -> {required_for_step?(:educational)}

  # Force step form to validate before it renders the next page.
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
end
