class ApplicationStepsController < ApplicationController
  before_filter :authenticate_user!
  include Wicked::Wizard
  #steps :contact, :educational, :purpose, :transcripts, :send_recommendations, :send_email, :complete
  steps *MailingAddress.form_steps

  def show
    @cs_application = current_user.cs_application

    case step

      when "mailing_address"
        if @cs_application.mailing_address.present?
          @contact = @cs_application.mailing_address
          @contact.name = @cs_application.first_name + " " + @cs_application.last_name
          puts 'found record......'
        else
          puts 'new record......'
          @contact = @cs_application.build_mailing_address
          @contact.name = @cs_application.first + " " + @cs_application.last
        end

      when "educational"
        if !params[:Add].nil?

          @institution = @cs_application.institutions.build

          @institution_all = @cs_application.institutions
          puts '-------------------------------add-----------------'
        else
          if @cs_application.institutions.present?
            @institution_all = @cs_application.institutions
            @institution = @cs_application.institutions.last
            puts '-------------------------------if-----------------'
          else
            @institution_all = @cs_application.institutions
            @institution = @cs_application.institutions.build
            puts '-------------------------------else-----------------'
          end
        end

      when "purpose_statement"
        if @cs_application.purpose_statement.present?
        @purpose_statement = @cs_application.purpose_statement
        else
        @purpose_statement = @cs_application.build_purpose_statement
        end


      when "transcripts"
        #if !params[:new].nil?
        @transcript = @cs_application.transcripts.build
        @transcript_all = @cs_application.transcripts
      #else


      when "send_recommendations"
        if @cs_application.recommendations.size==1
          @recommendation = @cs_application.recommendations.first
          @recommendation = @cs_application.recommendations.build
        elsif @cs_application.recommendations.size==2
          @recommendation = @cs_application.recommendations.first
          @recommendation = @cs_application.recommendations.second
        else
          @recommendation = @cs_application.recommendations.build
          @recommendation = @cs_application.recommendations.build
        end

      when "send_email"

    end

    render_wizard
  end
  
  def update
    @cs_application = current_user.cs_application
    case step
      
    when "mailing_address"
      if @cs_application.mailing_address.present?
        @contact = @cs_application.mailing_address
        #@contact.update_attributes(params[:mailing_address])
        @contact.update(form_params(step))
      else
        @contact = MailingAddress.new(form_params(step))
      end
      @contact.cs_application_id = @cs_application.id
      @contact.save
      @cs_application.progress = 40
     # @cs_application.is_citizen = params[:cs_application][:is_citizen]
     # @cs_application.telephone = params[:cs_application][:telephone]
      @cs_application.save
      render_wizard @contact
      
    when "educational"
      if params[:commit]== "Add"
        @institution = Institution.new
        @institution.cs_application_id = @cs_application.id
        #@institution.update_attributes(params[:institution])
        @institution.update(form_params(step))
        @institution.save
        @cs_application.progress = 60
        @cs_application.save
        puts '-------------------------------add-----------------'
        render_wizard #params[:Add => true]
      else
        if @cs_application.institutions.present?
          @institution = @cs_application.institutions.last
          #@institution.update_attributes(params[:institution])
          @institution.update(form_params(step))
          puts '-------------------------------if-----------------'
        else
          @institution = Institution.new(form_params(step))
        end
          @institution.cs_application_id = @cs_application.id
          @institution.save
          @cs_application.progress = 60
          @cs_application.save
          render_wizard @institution
      end

      when "purpose_statement"
        @purpose_statement = @cs_application.purpose_statement

        if params[:commit]== "Upload"
          check = params[:purpose_statement][:purpose].nil? rescue true
          if check
            render_wizard
          elsif @cs_application.purpose_statement.present?
            @purpose_statement.update(form_params(step))
            puts "update upload"
            render_wizard
          else
            @purpose_statement = PurposeStatement.new(:purpose => params[:purpose_statement][:purpose])
            @purpose_statement.cs_application_id = @cs_application.id
            @purpose_statement.save
            puts "new upload"
            render_wizard
          end
        else
          if !@cs_application.purpose_statement.present?

            @purpose_statement = PurposeStatement.new
          end

          @cs_application.progress = 70
          @cs_application.save
          render_wizard @purpose_statement
        end

      when "transcripts"
      if params[:commit]== "Upload"
          check = params[:transcript][:document].nil? rescue true
          if check
            render_wizard
          else
          @transcript = Transcript.new(:document => params[:transcript][:document])
          @transcript.cs_application_id = @cs_application.id
          @transcript.save
          @cs_application.progress = 80
          @cs_application.save
          puts "new"
          render_wizard
          end

      else
        if @cs_application.transcripts.present?
          @transcript = @cs_application.transcripts.last
          @transcript.update(form_params(step))
          puts "update"
        else
          @transcript = Transcript.new
        end
        render_wizard @transcript
      end


      when "send_recommendations"
      if @cs_application.recommendations.size==1
        @recommendation = @cs_application.recommendations.first
        @recommendation.update_attributes(params[:recommendation1])
        @recommendation.cs_application_id = @cs_application.id
        @recommendation.save
        @recommendation = Recommendation.new(params[:recommendation2])
        @recommendation.cs_application_id = @cs_application.id
        @recommendation.save

      elsif @cs_application.recommendations.size==2
        @recommendation = @cs_application.recommendations.first
        @recommendation.update_attributes(params[:recommendation1])
        @recommendation.cs_application_id = @cs_application.id
        @recommendation.save

        @recommendation = @cs_application.recommendations.second
        @recommendation.update_attributes(params[:recommendation2])
        @recommendation.cs_application_id = @cs_application.id
        @recommendation.save
      else
        @recommendation = Recommendation.new(params[:recommendation1])
        @recommendation.cs_application_id = @cs_application.id
        @recommendation.save

        @recommendation = Recommendation.new(params[:recommendation2])
        @recommendation.cs_application_id = @cs_application.id
        @recommendation.save
      end
      
      @cs_application.progress = 90
      @cs_application.save
      render_wizard @recommendation

    when "send_email"
      render_wizard @cs_application
    end

  rescue ActiveRecord::RecordNotFound

  end

  private
  def form_params(step)
    permitted_attributes = case step
                             when "mailing_address"
                               [:city, :address_line1, :address_line2, :name, :state_id, :zip, :cs_application_id]
                             when "educational"
                               [:attended_from, :attended_to, :city, :degree, :institution, :state_id, :cs_application_id]
                             when "send_recommendations"
                               [:cs_application_id, :email, :name, :status, :time_known_from, :time_known_to, :title]
                             when "transcript"
                               [:cs_application_id, :document]
                             when "purpose_statement"
                               [:cs_application_id, :purpose]
                           end

    if step == "mailing_address"
      params.require(:mailing_address).permit(permitted_attributes).merge(form_step: step)
    elsif step == "educational"
      params.require(:institution).permit(permitted_attributes).merge(form_step: step)
    elsif step == "send_recommendations"
      params.require(:recommendation).permit(permitted_attributes).merge(form_step: step)
    elsif step == "transcript"
      params.require(:transcript).permit(permitted_attributes).merge(form_step: step)
    elsif step == "purpose_statement"
      params.require(:purpose_statement).permit(permitted_attributes).merge(form_step: step)
    end
  end

end
