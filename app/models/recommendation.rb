class Recommendation < ActiveRecord::Base
  attr_accessible :cs_application_id, :email, :name, :status, :time_known_from, :time_known_to, :title

  STATUS_SENT = 1
  STATUS_COMPLETED = 2
  
  belongs_to :cs_application
  has_one :rating

  attr_accessor :form_step

  with_options if: -> { required_for_step?(:send_recommendations)} do |step|
    step.validates :email, :name, :title, presence: true
    step.validates :email, :email_format => true
  end

  def required_for_step?(step)
    # All fields are required if no form step is present
    # puts form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end


end
