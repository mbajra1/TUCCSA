class AddAttachmentDocumentToTranscripts < ActiveRecord::Migration
  def self.up
    change_table :transcripts do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :transcripts, :document
  end
end
