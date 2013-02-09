class CreateCsApplications < ActiveRecord::Migration
  def change
    create_table :cs_applications do |t|
      t.integer :user_id
      t.string :first
      t.string :middle
      t.string :last
      t.integer :tuid
      t.string :email

      t.timestamps
    end
  end
end
