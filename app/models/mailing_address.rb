class MailingAddress < ActiveRecord::Base
  #attr_accessible :city, :address_line1, :address_line2, :name, :state_id, :zip
  cattr_accessor :form_steps do
    %w(mailing_address educational purpose_statement transcripts send_recommendations send_email complete)
  end

  attr_accessor :form_step

  belongs_to :cs_application
  belongs_to :state

  validates :city, :address_line1, :name, :zip, presence: true, if: -> {required_for_step?(:mailing_address)}
  validates :name, length: { in: 2..100 }, if: -> {required_for_step?(:mailing_address)}
  validates :zip, length: { is: 5 }, if: -> {required_for_step?(:mailing_address)}
  validates :zip, numericality: { only_integer: true}, if: -> {required_for_step?(:mailing_address)}

  def required_for_step?(step)
    # All fields are required if no form step is present
    # puts form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
    return true if form_step.nil?|| self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
