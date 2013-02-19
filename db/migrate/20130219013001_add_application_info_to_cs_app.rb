class AddApplicationInfoToCsApp < ActiveRecord::Migration
  def change
    add_column :cs_applications, :telephone, :string
    add_column :cs_applications, :is_citizen, :boolean
    add_column :cs_applications, :signed_name, :string
    add_column :cs_applications, :status, :integer
    add_column :cs_applications, :progress, :integer
  end
end
