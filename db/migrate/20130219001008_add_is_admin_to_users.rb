class AddIsAdminToUsers < ActiveRecord::Migration
  def up
    add_column :users, :is_admin, :boolean, :default=>false

    User.create! do |r|
      r.email      = 'cybercorps@towson.edu'
      r.password   = 'password'
      r.is_admin = true
    end
  end

  def down
    remove_column :users, :is_admin
    User.find_by_email('cybercorps@towson.edu').try(:delete)
  end
end
