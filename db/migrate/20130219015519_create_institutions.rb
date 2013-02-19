class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :institution
      t.string :city
      t.integer :state_id
      t.datetime :attended_from
      t.datetime :attended_to
      t.string :degree

      t.timestamps
    end
  end
end
