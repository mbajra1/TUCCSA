class Transcript < ActiveRecord::Base
  attr_accessible :cs_application_id, :document
  
  belongs_to :cs_application
  has_attached_file :document
  validates_attachment_content_type :document, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']

 # has_attached_file :document, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 # validates_attachment_content_type :document, content_type: /\Aimage\/.*\Z/

end
