ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :updated_at
    column :sign_in_count
    column :is_admin

  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :is_admin, :label => "Super Administrator"
    end
    f.actions
  end

  create_or_edit = Proc.new {
    @user            = User.where(id: params[:id]).first_or_create
    @user.is_admin = params[:user][:is_admin]
    @user.attributes = params[:user].delete_if do |k, v|
      (k == "is_admin") ||
          (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      #render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
      render :edit
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit
  
end
