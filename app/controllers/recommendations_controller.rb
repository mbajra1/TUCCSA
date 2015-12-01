class RecommendationsController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource

  def update
    @recommendation = Recommendation.find(params[:id])

    respond_to do |format|
      if @recommendation.update_attributes(my_sanitizer)
        format.html { redirect_to '/application_steps/send_recommendations', notice: 'Cs application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cs_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_sanitizer
    params.require(:recommendation).permit(:cs_application_id, :email, :name, :status, :time_known_from, :time_known_to, :title)
  end
end
