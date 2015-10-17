class CreatePurposeStatements < ActiveRecord::Migration
  def change
    create_table :purpose_statements do |t|
      t.integer :cs_application_id, :null => false, :references => [:cs_applications, :id]

      t.timestamps null: false
    end
  end
end
