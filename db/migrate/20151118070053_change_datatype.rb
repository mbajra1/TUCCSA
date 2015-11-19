class ChangeDatatype < ActiveRecord::Migration
  def change
    change_column :cs_applications, :towson_id_number, :integer
  end
end
