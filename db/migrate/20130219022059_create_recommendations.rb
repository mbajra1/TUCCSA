class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :cs_application_id
      t.string :name
      t.string :title
      t.string :email
      t.datetime :time_known_from
      t.datetime :time_known_to
      t.integer :status

      t.timestamps
    end
  end
end
