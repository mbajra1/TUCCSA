class InstitutionsController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer
  skip_authorize_resource :only => [:update, :edit, :destroy]

  def edit
    @institution = Institution.find(params[:id])
    @institutes = Institution.where("cs_application_id=?", current_user.cs_application.id)

     if @institutes.include?(@institution)
        respond_to do |format|
          format.html { render action: "edit" }
        end
      else
        flash[:error] = "Access Denied"
        redirect_to '/application_steps/educational'

      end
  end

  def update
    @institution = Institution.find(params[:id])

    respond_to do |format|
      if @institution.update(my_sanitizer)
       cs_application = CsApplication.find_by_user_id(current_user.id)
       if cs_application.progress == 100
         format.html { redirect_to "/cs_application/review/#{cs_application.id}", notice: 'Instituion Information was successfully updated.' }
         else
        format.html { redirect_to '/application_steps/educational', notice: 'Instituion Information was successfully updated.' }
        format.json { head :no_content }
         end
      else
        format.html { render action: "edit" }
        format.json { render json: @cs_application.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy

    respond_to do |format|
      format.html { redirect_to '/application_steps/educational', :notice => 'Institution removed' }
      format.json { head :no_content }
    end
  end

  def my_sanitizer
    params.require(:institution).permit(:attended_from, :attended_to, :city, :degree, :institution, :state_id, :cs_application_id)
  end
end
