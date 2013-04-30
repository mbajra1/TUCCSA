class AddPasswordToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :password, :string
  end
end
