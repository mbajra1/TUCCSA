class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :cs_applications, :towson_ID_number, :towson_id_number
  end
end
