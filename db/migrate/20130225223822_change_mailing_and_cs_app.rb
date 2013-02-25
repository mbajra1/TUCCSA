class ChangeMailingAndCsApp < ActiveRecord::Migration
  def up
    remove_column :cs_applications, :mailing_address_id
    add_column :mailing_addresses, :cs_application_id, :integer
  end

  def down
  end
end
