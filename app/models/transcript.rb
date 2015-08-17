class Transcript < ActiveRecord::Base
  attr_accessible :cs_application_id, :document
  
  belongs_to :cs_application
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => %w(application/pdf)
  
end
