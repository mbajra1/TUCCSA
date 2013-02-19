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
        format.html { redirect_to @cs_application, notice: 'Cs application was successfully created.' }
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
        format.html { redirect_to @cs_application, notice: 'Cs application was successfully updated.' }
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
end
