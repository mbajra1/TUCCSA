class CsApplicationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /cs_applications
  # GET /cs_applications.json
  def index
    @cs_application = CsApplication.find_by_user_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cs_applications }
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
    @cs_application = CsApplication.new(params[:cs_application])

    respond_to do |format|
      if @cs_application.save
        @cs_application.progress=20
        @cs_application.save
        format.html { redirect_to application_steps_path, notice: 'Cs application was successfully created.' }
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

    respond_to do |format|
      if @cs_application.update_attributes(params[:cs_application])
        format.html { redirect_to application_steps_path, notice: 'Cs application was successfully updated.' }
        format.json { head :no_content }
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
  
  def send_invitation
    recommendation = Recommendation.find_by_id(params[:recommendation_id])
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
  
  def review
    @cs_application = CsApplication.find_by_user_id(current_user.id)
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ApplicationReviewPdf.new(@cs_application, view_context)
          send_data pdf.render, filename: "applicant_#{current_user.id}_#{@cs_application.id}.pdf",
                                type: "application/pdf",
                                disposition: "inline"

      end
    end
  end
  
  def generate_rating_code(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end
  
end
