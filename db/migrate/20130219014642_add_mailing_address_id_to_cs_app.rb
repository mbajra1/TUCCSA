class AddMailingAddressIdToCsApp < ActiveRecord::Migration
  def change
    add_column :cs_applications, :mailing_address_id, :integer
  end
end
