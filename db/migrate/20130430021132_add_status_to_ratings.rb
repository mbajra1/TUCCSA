class AddStatusToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :status, :integer, :default=>0
  end
end
