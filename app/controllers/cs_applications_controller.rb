class CsApplicationsController < ApplicationController
  before_filter :authenticate_user!

  # load and authorize the actions once instead of defining on each action
  load_and_authorize_resource param_method: :my_sanitizer
  # skip authorization on the actions
  skip_authorize_resource :only => [:index, :new, :remove_purpose, :remove_transcript, :send_invitation, :submit_application]

  require 'rubygems'
  require 'zip'
  require "open-uri"

  # GET /cs_applications
  # GET /cs_applications.json
 def index
   @cs_application = CsApplication.find_by_user_id(current_user.id)

   if current_user.is_admin?
       redirect_to "/admin/dashboard"
   else
     respond_to do |format|
     format.html # index.html.erb
     format.json { render json: @cs_applications }
     end
   end
  end

  # GET /cs_applications/1
  # GET /cs_applications/1.json
  def show
    @cs_application = CsApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cs_application }
    end
  end

  # GET /cs_applications/new
  # GET /cs_applications/new.json
  def new
    @cs_application = CsApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cs_application }
    end
  end

  # GET /cs_applications/1/edit
  def edit
    @cs_application = CsApplication.find(params[:id])
  end

  # POST /cs_applications
  # POST /cs_applications.json
  def create
   # @cs_application = CsApplication.new(params[:cs_application])
     @cs_application = CsApplication.new(my_sanitizer)
     @cs_application.email = current_user.email
     @cs_application.progress=15
     @cs_application.save
   
    respond_to do |format|
      if @cs_application.save
         @cs_application.status="STARTED"
         @cs_application.save
        format.html { redirect_to application_steps_path }
        format.json { render json: @cs_application, status: :created, location: @cs_application }
      else
        format.html { render action: "new" }
        format.json { render json: @cs_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cs_applications/1
  # PUT /cs_applications/1.json
  def update
   @cs_application = CsApplication.find(params[:id])

   if @cs_application.progress!=100
     if @cs_application.progress < 30
       @cs_application.progress=15
       @cs_application.save
     end
   end

    respond_to do |format|
      if @cs_application.update(my_sanitizer)
        if @cs_application.progress == 100
          format.html { redirect_to "/cs_application/review/#{@cs_application.id}", notice: 'Basic Information was successfully updated.' }
        else
          format.html { redirect_to application_steps_path}
          format.json { head :no_content }
        end
      else
          format.html { render action: "edit" }
          format.json { render json: @cs_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cs_applications/1
  # DELETE /cs_applications/1.json
  def destroy
    @cs_application = CsApplication.find(params[:id])
    @cs_application.destroy

    respond_to do |format|
      format.html { redirect_to cs_applications_url }
      format.json { head :no_content }
    end
  end


  # Deliver the recommendation link via email for rating
  def send_invitation
    recommendation = Recommendation.find_by_id(params[:recommendation_id])
    if recommendation.cs_application.progress !=100 && recommendation.cs_application.progress <=90
      recommendation.cs_application.progress = recommendation.cs_application.progress + 10
      recommendation.cs_application.save
    end
    rating = Rating.new()
    recommendation.status = Recommendation::STATUS_SENT
    recommendation.save
    rating.recommendation_id = recommendation.id
    rating.password = generate_rating_code(8)
    rating.notes = "Enter you additional notes"
    rating.save
    link = "http://#{request.host}:#{request.port}/ratings/verify_password/#{rating.id}"
    UserMailer.send_invitation(recommendation, link, rating).deliver
    redirect_to '/application_steps/send_email/', :notice => 'Invitation Email Sent' 
    #redirect_to verify_password_path(rating.id), :notice => 'Invitation Email Sent' 
  end

  # render the pdf
  def review
    @cs_application = CsApplication.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ApplicationReviewPdf.new(@cs_application, view_context)
         send_data pdf.render,
                               filename: "user_#{current_user.id}_#{@cs_application.id}.pdf",
                               type: "application/pdf",
                               disposition: "inline"
                                
        #Saving file
       # pdf = ApplicationReviewPdf.new(@cs_application, view_context)
       # save_path = Rails.root.join('pdfs',"filename.pdf")
        # File.open(save_path, 'wb') do |file|
          # file << pdf
       # end

      end
    end

  end

  # mark application status as reviewed
  def mark_as_reviewed
    cs_application = CsApplication.find_by_id(params[:id])
    if cs_application.progress<100
      redirect_to :back, :notice=>'You cannot mark this application as reviewed. The application is not yet submitted by the student.'
    else
      cs_application.status = CsApplication::STATUS_REVIEWED
      cs_application.save
      redirect_to :back #:notice=>'Application is now marked as reviewed. Student has been notified.'
    end
  end

  # mark application status as denied
  def mark_as_denied
    cs_application = CsApplication.find_by_id(params[:id])
    if cs_application.progress<100
      redirect_to :back, :notice=>'You cannot mark this application as denied. The application is not yet submitted by the student.'
    else
      cs_application.status = CsApplication::STATUS_DENIED
      cs_application.save
     # UserMailer.send_denied_message(cs_application).deliver
     redirect_to :back #:notice=>'Application is now marked as denied. Student has been notified.'
    end
  end

  # mark application status as approved
  def mark_as_approved
    cs_application = CsApplication.find_by_id(params[:id])
    if cs_application.progress!=100
      redirect_to :back, :notice=>'You cannot mark this application as approved. The application is not yet submitted by the student.'
    else
      cs_application.status = CsApplication::STATUS_APPROVED
      cs_application.save
     # UserMailer.send_approved_message(cs_application).deliver
     redirect_to :back #:notice=>'Application is now marked as approved. Student has been notified.'
    end
  end

  # download the attached documents
  def download_package
      cs_application = CsApplication.find_by_id(params[:id])
      file_name = "package.zip"
      transcripts_list = cs_application.transcripts
      purpose= cs_application.purpose_statement
      file_name  = "applicant_#{cs_application.user.id}_application_#{cs_application.id}"
      file_name  = "#{file_name}.zip"
      
      temp_file  = Tempfile.new("#{file_name}-#{cs_application.id}")
      Zip::OutputStream.open(temp_file.path) do |zos|
        zos.put_next_entry(purpose.purpose_file_name)
        zos.print IO.read(purpose.purpose.path)
        transcripts_list.each do |file|
          zos.put_next_entry(file.document_file_name)
          zos.print IO.read(file.document.path)
        end
      end
      
      send_file temp_file.path, :type => 'application/zip',
                                :disposition => 'attachment',
                                :filename => file_name
      temp_file.close
  end

  # generate rating code for the rating page
  def generate_rating_code(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  # notifies the application has been submitted
  def submit_application
    application = CsApplication.find_by_id(params[:id])
    
    if application.progress<100
      redirect_to review_application_url, :notice => "You application is not complete yet and cannot be submitted at this time"
    else
      application.progress = 100
      application.status = CsApplication::STATUS_SUBMITTED
      application.save
      UserMailer.submit_application_applicant(application).deliver
      UserMailer.submit_application_admin(application).deliver
      redirect_to root_url, :notice => "Congratulations!! You have successfully submitted the application. We will get in touch with you."
    end
  end

  # remove the attached transcript
  def remove_transcript
    transcript = Transcript.find(params[:cs_application_id])
    transcript.destroy
    redirect_to :back, :notice => 'Transcript has been removed.'
  end

  # remove the attached purpose
  def remove_purpose
    purpose = PurposeStatement.find(params[:cs_application_id])
    #purpose = current_user.cs_application.purpose_statement
    purpose.destroy

    redirect_to :back, flash:{success: 'Purpose Statement has been removed.'}
  end

 # strong parameter for cs application to permit attributes on update
  private
  def my_sanitizer
    params.require(:cs_application).permit(:email, :first_name, :last_name, :middle_name, :towson_id_number,:is_citizen, :phone, :status, :progress, :user_id)
  end

end
