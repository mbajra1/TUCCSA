class ApplicationReviewPdf < Prawn::Document

  # Generate the pdf view

  # initialize all the methods
  def initialize(cs_application, view)
    super(top_margin: 50)
    @cs_application = cs_application
    @view = view
    header
    basic
    institution
    purpose
    footer
  end
  
  def header
    text "Towson University", size: 15, style: :bold, align: :center
    image "#{Rails.root}/app/assets/images/SFSLogoMain.png", width: 30, height: 25, position: :center
    text "CyberCorps: Scholarship for Service", size: 13, style: :bold, align: :center
    move_down 5
    text "Application \##{@cs_application.id}", size: 10, style: :bold, align: :center
    move_down 3
    stroke_horizontal_rule
  end
  
  def basic
    move_down 20
    text "Last Name: <u><i>#{@cs_application.last_name}</u></i>                                    First Name: <u><i>#{@cs_application.first_name}</u></i>                            Middle: <u><i>#{@cs_application.middle_name}</u></i>", size: 10, :inline_format => true
    move_down 10
    text "Towson Student ID: <u><i>#{@cs_application.towson_id_number}</i></u>", size: 10, :inline_format => true
    move_down 10
    text "Preferred mailing address for scholarship correspondence: ", size: 10
    move_down 5
    text "<u><i>#{@cs_application.mailing_address.name}</i></u>", :inline_format => true, size: 10
    text "<u><i>#{@cs_application.mailing_address.address_line1}, #{@cs_application.mailing_address.address_line2}</i></u>", :inline_format => true, size: 10
    text "<u><i>#{@cs_application.mailing_address.city}, #{@cs_application.mailing_address.state.name} #{@cs_application.mailing_address.zip}</u></i>", :inline_format=>true, size: 10
    move_down 10
    text "Email: <u><i>#{@cs_application.email}</i></u>                       Telephone: <u><i>#{@cs_application.phone}</i></u>", size: 10, :inline_format=>true
    move_down 10
    text "<b>I declare that I am a citizen of the United State of America:</b>  <u><i>#{@cs_application.is_citizen? ? "[X]" : "[]"}</i></u>", size: 10, :inline_format=>true 
    move_down 5
    text "<u><i>#{@cs_application.first_name} #{@cs_application.last_name}\t\t</i></u>", :inline_format => true, size: 10
    text "Print name", :inline_format => true, size: 10
    move_down 10
    text "Please list all colleges or universities that you have attended below, starting with all current", size: 10
    text "institution in which you are enrolled (or accepted for enrollment) as of the date of this statement:", size: 10
  end
  
  def institution
    move_down 15
    table institution_rows do
      row(0).font_style = :bold
      column(1..3).align = :right
      self.header = true
    end
  end
  
  def institution_rows
    [["Institution", "City, State", "Dates Attended", "Degree Earned (or Expected)"]] +
    @cs_application.institutions.map do |institution|
      [institution.institution, (institution.city.blank? ? '-' : institution.city)  + ", " + (institution.state.nil? ? '-' : institution.state.name), institution.attended_from + " to " + institution.attended_to, institution.degree]
    end
  end
  
  def purpose
    move_down 10
    text "<b>Please include:</b>", size: 10, :inline_format=>true
    move_down 3
    text "1.  A brief statement of purpose describing your goals and motivations to pursue a career in", size: 10
    text "    Information Assurance and Comupter Security (maximum 2 pages): <u><i>#{!@cs_application.purpose_statement.purpose.blank? ? "Attached: #{@cs_application.purpose_statement.purpose_file_name}" : "Not Provided"}</i></u>", size: 10, :inline_format=>true
    # pdf.image "#{Rails.root}/public"+ @cs_application.purpose_statement.purpose.url.sub!(/\?.+\Z/, '')
    move_down 5
    text "2.  Transcript(s) from all of the colleges and universities listed above: <u><i>#{!@cs_application.transcripts.nil? ? "Attached: #{@cs_application.transcripts.size} Transcripts" : "Not Provided"}</i></u>", size: 10, :inline_format=>true
    move_down 5
    text "3.  Two recommendations", size: 10, :inline_format=>true
    move_down 3
    text "First recommendation from:      <u><i>#{!@cs_application.recommendations.first.nil? ? @cs_application.recommendations.first.name : "Not Provided"}</i></u>       Status:      <u><i>#{@cs_application.recommendations.first.nil? ? "Invitition Not Sent" : "Invitition Sent"}</i></u>", size: 10, :inline_format=>true 
    text "Second recommendation from:      <u><i>#{!@cs_application.recommendations.second.nil? ? @cs_application.recommendations.second.name : "Not Provided"}</i></u>       Status:      <u><i>#{@cs_application.recommendations.second.nil? ? "Invitition Not Sent" : "Invitition Sent"}</i></u>", size: 10, :inline_format=>true
    move_down 5
    text "4.  A brief description of any academic recognition, honors, disctinction, or awards that you", size: 10
    text "    have received.", size: 10
  end
  
  def footer
    move_down 20
    text "<b> Completed application should be sent electronically using the TU Cybercorp Scholarship web application. Please contact TU CS department for any questions. </b>", size: 10, :inline_format=> true
  end
end