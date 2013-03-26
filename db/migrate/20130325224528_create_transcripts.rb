class CreateTranscripts < ActiveRecord::Migration
  def change
    create_table :transcripts do |t|
      t.integer :cs_application_id

      t.timestamps
    end
  end
end
