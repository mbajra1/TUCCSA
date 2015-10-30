class MailingAddressesController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer

  skip_authorize_resource :only => [:update, :edit]

  def edit
    @contact = MailingAddress.find(params[:id])
    contact = MailingAddress.find_by('cs_application_id=?', current_user.cs_application.id)
    if contact.id != @contact.id
      flash[:error] = "Access Denied"
      redirect_to '/application_steps/mailing_address'
    else
      respond_to do |format|
        format.html { render action: "edit" }
      end
    end
  end

  def update
    @contact = MailingAddress.find(params[:id])

    respond_to do |format|
      if @contact.update(my_sanitizer)
        format.html { redirect_to '/application_steps/mailing_address', notice: 'Mailing Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cs_application.errors, status: :unprocessable_entity }
      end
    end
  end

    def create
    @contact = CsApplication.new(my_sanitizer)

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

  def my_sanitizer
    params.require(:mailing_address).permit(:city, :address_line1, :address_line2, :name, :state_id, :zip, :cs_application_id)
  end
end
