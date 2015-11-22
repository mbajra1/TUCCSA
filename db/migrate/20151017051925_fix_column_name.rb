class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :cs_applications, :first, :first_name
    rename_column :cs_applications, :middle, :middle_name
    rename_column :cs_applications, :last, :last_name
    rename_column :cs_applications, :tuid, :towson_id_number
    rename_column :mailing_addresses, :line1, :address_line1
    rename_column :mailing_addresses, :line2, :address_line2
  end
end
