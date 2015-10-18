class ChangeStatusDataType < ActiveRecord::Migration
  def change
  # change_column :cs_applications, :status, :string
    change_column :recommendations, :status, :string
    change_column :ratings, :status, :string
  end
end
