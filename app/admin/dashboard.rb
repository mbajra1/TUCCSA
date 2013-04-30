ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    section "Recent Users" do
      table_for User.order("created_at desc").limit(5) do
        column :id
        column :email
        column :created_at
        column :current_sign_in_at
        column :sign_in_count
      end
      strong {link_to "View all users", admin_users_path}
    end
    
    section "Recent Applications" do
      table_for CsApplication.order("created_at desc").limit(5) do
        column :id
        column :first
        column :last
        column :tuid
        column :progress
        column :created_at
      end
      strong {link_to "View all applications", admin_cs_applications_path}
    end
    
  end
end
