class AddPurposeStatementToCsApp < ActiveRecord::Migration
  def change
    add_column :cs_applications, :purpose_statement, :text
  end
end
