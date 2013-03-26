class ApplicationStepsController < ApplicationController
  include Wicked::Wizard
  steps :contact, :educational, :purpose, :send_recommendations, :send_email, :complete
  
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
      if !params[:new].nil?
        @institution = @cs_application.institutions.build
        @institution_all = @cs_application.institutions
      else
        if @cs_application.institutions.present?
          @institution_all = @cs_application.institutions
          @institution = @cs_application.institutions.last
        else
          @institution_all = @cs_application.institutions
          @institution = @cs_application.institutions.build
        end
      end
    when :purpose
      #if !params[:new].nil?
        @transcript = @cs_application.transcripts.build
        @transcript_all = @cs_application.transcripts
      #else
        
      
    when :send_recommendations
      if @cs_application.recommendations.size==1
        @recommendation1 = @cs_application.recommendations.first
        @recommendation2 = @cs_application.recommendations.build
      elsif @cs_application.recommendations.size==2
        @recommendation1 = @cs_application.recommendations.first
        @recommendation2 = @cs_application.recommendations.second
      else
        @recommendation1 = @cs_application.recommendations.build
        @recommendation2 = @cs_application.recommendations.build
      end
    end
    render_wizard
  end
  
  def update
    @cs_application = current_user.cs_application
    case step
      
    when :contact
      if @cs_application.mailing_address.present?
        @contact = @cs_application.mailing_address
        @contact.update_attributes(params[:mailing_address])
      else
        @contact = MailingAddress.new(params[:mailing_address])
      end
      @contact.cs_application_id = @cs_application.id
      @contact.save
      @cs_application.progress = 40
      @cs_application.is_citizen = params[:cs_application][:is_citizen]
      @cs_application.telephone = params[:cs_application][:telephone]
      @cs_application.save
      render_wizard @cs_application
      
    when :educational
      
      if params[:commit]== "new"
        @institution = Institution.new(params[:institution])
        @institution.cs_application_id = @cs_application.id
        @institution.save
        @cs_application.progress = 60
        @cs_application.save
        render_wizard params[:new => true]
      else
        if @cs_application.institutions.present?
          @institution = @cs_application.institutions.last
          @institution.update_attributes(params[:institution])
        else
          @institution = Institution.new(params[:institution])
        end
          @institution.cs_application_id = @cs_application.id
          @institution.save
          @cs_application.progress = 60
          @cs_application.save
          render_wizard @cs_application
      end
    when :purpose
      
      if params[:commit]== "Upload"
        @transcript = Transcript.new(:document => params[:cs_application][:transcripts][:document])
        @transcript.cs_application_id = @cs_application.id
        @transcript.save
        #@cs_application.save
        render_wizard
      else
        if !params[:cs_application].blank?
          @cs_application.purpose = params[:cs_application][:purpose]
          @cs_application.progress = 70
          @cs_application.save
          render_wizard @cs_application
        else
          render_wizard @cs_application
        end
      end
      
    when :send_recommendations
      if @cs_application.recommendations.size==1
        @recommendation1 = @cs_application.recommendations.first
        @recommendation1.update_attributes(params[:recommendation1])
        @recommendation2 = Recommendation.new(params[:recommendation2])
        @recommendation2.cs_application_id = @cs_application.id
        @recommendation2.save
        @recommendation1.cs_application_id = @cs_application.id
        @recommendation1.save
      elsif @cs_application.recommendations.size==2
        @recommendation1 = @cs_application.recommendations.first
        @recommendation2 = @cs_application.recommendations.second
        @recommendation1.update_attributes(params[:recommendation1])
        @recommendation2.update_attributes(params[:recommendation2])
        @recommendation1.cs_application_id = @cs_application.id
        @recommendation1.save
        @recommendation2.cs_application_id = @cs_application.id
        @recommendation2.save
      else
        @recommendation1 = Recommendation.new(params[:recommendation1])
        @recommendation2 = Recommendation.new(params[:recommendation2])
        @recommendation1.cs_application_id = @cs_application.id
        @recommendation1.save
        @recommendation2.cs_application_id = @cs_application.id
        @recommendation2.save
      end
      
      @cs_application.progress = 90
      @cs_application.save
      render_wizard @cs_application

    when :send_email
      render_wizard @cs_application
    end
  end
  
  
end
