class ChangeStatusDataType < ActiveRecord::Migration
  def change
    change_column :cs_applications, :status, :string
  end
end
