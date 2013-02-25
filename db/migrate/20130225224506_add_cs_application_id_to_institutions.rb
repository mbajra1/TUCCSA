class AddCsApplicationIdToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :cs_application_id, :integer
  end
end
