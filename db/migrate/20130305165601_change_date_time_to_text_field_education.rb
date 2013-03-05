class ChangeDateTimeToTextFieldEducation < ActiveRecord::Migration
  def up
    change_column :institutions, :attended_from, :text
    change_column :institutions, :attended_to, :text
  end

  def down
    change_column :institutions, :attended_from, :datetime
    change_column :institutions, :attended_to, :datetime
  end
end
