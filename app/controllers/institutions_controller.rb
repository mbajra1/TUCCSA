class InstitutionsController < InheritedResources::Base
  def update
    @institution = Institution.find(params[:id])

    respond_to do |format|
      if @institution.update_attributes(params[:institution])
        format.html { redirect_to '/application_steps/educational', notice: 'Cs application was successfully updated.' }
        format.json { head :no_content }
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
  
  
end
