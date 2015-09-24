class RatingsController < InheritedResources::Base
  before_filter :authenticate_user!
  def update
    @rating = Rating.find(params[:id])
    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        
        format.html { render action: "show", notice: 'Thank you, your ratings have been submitted. You can either edit your ratings or close this browser.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", notice: 'Something went wrong' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @rating = Rating.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end
  
  def verify_password
    @rating = Rating.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end
  
  def submit_password
    @password = params[:password]
    if @password == Rating.find_by_id(params[:rating_id]).password
      redirect_to "/ratings/#{params[:id]}/edit", notice: 'Verification Complete. Thank you.'
    else
      redirect_to verify_password_path(params[:id]), notice: 'Password verification failed, please try again.'
    end
  end
  
end
