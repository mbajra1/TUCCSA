class RatingsController < InheritedResources::Base
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
      format.json { render json: @cs_application }
    end
  end
  
end
