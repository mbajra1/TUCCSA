ActiveAdmin.register CsApplication do
  index do
    column :id
    column :first
    column :last
    column :tuid
    column :email
    column :progress
    column :status
    
    column "View" do |app|
      link = "/admin/cs_applications/#{app.id}"
      link_to "View", link
    end
    
  end

  action_item :only => :show do
    link_to t('.print'),
                review_application_path(format: "pdf"), :target => '_blank', :class => 'btn btm-primary'
  end
  
  action_item :only => :show do
    link_to t('.download'),
                download_package_path(cs_application)
  end
  
  action_item :only => :show do
    link_to t('.mark_reviewed'),
                mark_as_reviewed_path(cs_application)
  end
  
  action_item :only => :show do
    link_to t('.mark_denied'),
                mark_as_denied_path(cs_application)
  end
  
  action_item :only => :show do
    link_to t('.mark_approved'),
                mark_as_approved_path(cs_application)
  end
  
  show do
    
    h2 'Application ID: ' + cs_application.id.to_s
    panel "Basic Information" do
      h4 'Applcant First Name: ' + cs_application.first
      h4 'Applcant Middle Name: ' + cs_application.middle
      h4 'TU ID: ' + cs_application.tuid.to_s
      h4 'Email address: ' + cs_application.email
      h4 'Telephone: ' + cs_application.telephone
      h4 'US Citizen: ' + cs_application.is_citizen.to_s
    end
    
    panel "Contact Information" do
      h4 "Full Name: " + (!cs_application.mailing_address.name.blank? ? cs_application.mailing_address.name : 'Not Provided')
      h4 "Address Line 1: " + (!cs_application.mailing_address.line1.blank? ? cs_application.mailing_address.line1 : 'Not Provided')
      h4 "Address Line 2: " + (!cs_application.mailing_address.line2.blank? ? cs_application.mailing_address.line2 : 'Not Provided')
      h4 "City: " + (!cs_application.mailing_address.city.blank? ? cs_application.mailing_address.city : 'Not Provided')
      h4 "State: " + (!cs_application.mailing_address.state_id.blank? ? cs_application.mailing_address.state.name : 'Not Provided')
      h4 "Zip: " + (!cs_application.mailing_address.zip.blank? ? cs_application.mailing_address.zip.to_s : 'Not Provided')
    end
    
    panel "Educational Information" do
      count = cs_application.institutions.count
      if count == 0
        h4 "Not Prodided"
      else
        cs_application.institutions.each do |inst|
          h4 "Institution name: " + inst.institution
          h4 "City: " + inst.city
          h4 "State: " + inst.state.name
          h4 "Attended From: " + inst.attended_from
          h4 "Attended To: " + inst.attended_to
          h4 "Degree: " + inst.degree
          h4 "____________________________________________ "
        end
      end
    end
    
    panel "Purpose Statement" do
      if !cs_application.purpose.nil?
        (link_to cs_application.purpose_file_name, cs_application.purpose.url)
      else
        h4 + "Not Provided"
      end
    end
    
    panel "Transcripts" do
      count = cs_application.transcripts.count
      if count==0
        h4 + "Not Provided"
      else
        cs_application.transcripts.each do |transcript|
          (link_to transcript.document_file_name, transcript.document.url)
        end
      end
    end
    
    panel "Recommendations and Ratings" do
      if !cs_application.recommendations.first.nil?
        recommendation1 = cs_application.recommendations.first
        h4 "Recommender: " +  recommendation1.name
        if recommendation1.status==1 || recommendation1.status==2
          h4 "Status: Invitation Sent"
          h4 "Student Ratings (Scale 1 to 5, 5 being excellent)"
          rating = recommendation1.rating
          h5 "Intellect: " + rating.intellect.to_s
          h5 "Leadership: " + rating.leadership.to_s
          h5 "Written: " + rating.written.to_s
          h5 "Verbal: " + rating.verbal.to_s
          h5 "Reliability: " + rating.reliability.to_s
          h5 "Timeliness: " + rating.timeliness.to_s
          h5 "Maturity: " + rating.maturity.to_s
          h5 "Commitment: " + rating.commitment.to_s
          h5 "Independent: " + rating.independent.to_s
          h5 "Extra Notes: " + rating.notes
        else
          h4 "Status: Invitation Not Sent"
        end
      end
      h4 "________________________________________________________________________________________"
      if !cs_application.recommendations.second.nil?
        recommendation1 = cs_application.recommendations.second
        h4 "Recommender: " +  recommendation1.name
        if recommendation1.status==1 || recommendation1.status==2
          h4 "Status: Invitation Sent"
          h4 "Student Ratings (Scale 1 to 5, 5 being excellent)"
          rating = recommendation1.rating
          h5 "Intellect: " + rating.intellect.to_s
          h5 "Leadership: " + rating.leadership.to_s
          h5 "Written: " + rating.written.to_s
          h5 "Verbal: " + rating.verbal.to_s
          h5 "Reliability: " + rating.reliability.to_s
          h5 "Timeliness: " + rating.timeliness.to_s
          h5 "Maturity: " + rating.maturity.to_s
          h5 "Commitment: " + rating.commitment.to_s
          h5 "Independent: " + rating.independent.to_s
          h5 "Extra Notes: " + rating.notes
        else
          h4 "Status: Invitation Not Sent"
        end
      end
    end
    active_admin_comments
  end

end
