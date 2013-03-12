class AddAttachmentPurposeToCsApplications < ActiveRecord::Migration
  def self.up
    change_table :cs_applications do |t|
      t.attachment :purpose
    end
  end

  def self.down
    drop_attached_file :cs_applications, :purpose
  end
end
