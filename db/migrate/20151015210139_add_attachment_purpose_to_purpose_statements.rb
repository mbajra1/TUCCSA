class AddAttachmentPurposeToPurposeStatements < ActiveRecord::Migration
  def self.up
    change_table :purpose_statements do |t|
      t.attachment :purpose
    end
  end

  def self.down
    remove_attachment :purpose_statements, :purpose
  end
end
