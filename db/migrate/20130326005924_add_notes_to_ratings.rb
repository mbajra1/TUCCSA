class AddNotesToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :notes, :text
  end
end
