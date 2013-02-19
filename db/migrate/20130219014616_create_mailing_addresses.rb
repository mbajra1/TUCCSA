class CreateMailingAddresses < ActiveRecord::Migration
  def change
    create_table :mailing_addresses do |t|
      t.string :name
      t.string :line1
      t.string :line2
      t.string :city
      t.integer :state_id
      t.integer :zip

      t.timestamps
    end
  end
end
