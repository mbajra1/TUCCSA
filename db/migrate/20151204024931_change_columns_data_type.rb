class ChangeColumnsDataType < ActiveRecord::Migration
  def self.up
    change_column :cs_applications, :towson_id_number, :string
  end
end
