class ApplicationStepsController < ApplicationController
  include Wicked::Wizard
  steps :contact, :educational, :purpose, :send_recommendations
  
  def show
    @cs_application = current_user.cs_application
    case step
    when :contact
      if @cs_application.mailing_address.present?
        @contact = @cs_application.mailing_address
        puts 'found record......'
      else
        puts 'new record......'
        @contact = @cs_application.build_mailing_address
      end
    when :educational
    when :purpose
    when :send_recommendations
    end
    
    render_wizard
  end
  
  def update
    @cs_application = current_user.cs_application
    case step
    when :contact
      @contact = MailingAddress.new(params[:mailing_address])
      @contact.cs_application_id = @cs_application.id
      @contact.save
    when :educational
      
    when :purpose
    when :send_recommendations
    
    end
    
    #@cs_application.attributes = params[:cs_application]

    render_wizard @cs_application
  end
  
end
