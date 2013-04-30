class UserMailer < ActionMailer::Base
  
  default :from => 'cybercorps@towson.edu'
  
  def send_invitation(invite, link, rating)
    @invite = invite
    @rating = rating
    @link = link
    mail(:to => "#{invite.email}", :subject => "Towson University Cyber Security Student Recommendation Request")
  end
  
end