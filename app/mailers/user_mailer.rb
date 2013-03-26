class UserMailer < ActionMailer::Base
  
  default :from => 'cybersecurityapp@towson.edu'
  
  def send_invitation(invite, link)
    @invite = invite
    @link = link
    mail(:to => "#{invite.email}", :subject => "Towson University Cyber Security Student Recommendation Request")
  end
  
end