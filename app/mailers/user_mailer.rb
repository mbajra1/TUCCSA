class UserMailer < ActionMailer::Base
  
  default :from => 'cybercorps@towson.edu'
  
  def send_invitation(invite, link, rating)
    @invite = invite
    @rating = rating
    @link = link
    mail(:to => "#{invite.email}", :subject => "Towson University Cyber Security Student Recommendation Request")
  end
  
  def send_denied_message(application)
    @application = application
    mail(:to => "#application.email", :subject => "Towson University CyberCorps Application Status")
  end
  
  def send_approved_message(application)
    @application = application
    mail(:to => "#application.email", :subject => "Towson University CyberCorps Application Status")
  end
  
end