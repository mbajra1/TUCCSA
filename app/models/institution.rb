class Institution < ActiveRecord::Base
  attr_accessible :attended_from, :attended_to, :city, :degree, :institution, :state_id, :cs_application_id

  attr_accessor :form_step

  belongs_to :cs_application
  belongs_to :state

  validates :attended_from, :attended_to, :city, :degree, :institution, presence: true, if: -> {required_for_step?(:educational)}
  validates :state_id, presence: { message: "state must be selected" }
  validates :city, :degree, :institution, format: { with: /[a-zA-Z\s]*/, message: "only allows letters" }, if: -> {required_for_step?(:educational)}

  def required_for_step?(step)
    # All fields are required if no form step is present
    # puts form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end


end
