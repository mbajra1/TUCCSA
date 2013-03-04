class MailingAddressesController < InheritedResources::Base
    
    def create
    @contact = CsApplication.new(params[:contact])

    respond_to do |format|
      if @contact.save
        @contact.cs_application.progress=40
        @contact.save
        format.html { redirect_to application_steps_path, notice: 'Cs application was successfully created.' }
        format.json { render json: @contact, status: :created, location: @cs_application }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
end
