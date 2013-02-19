class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :recommendation_id
      t.integer :intellect
      t.integer :leadership
      t.integer :written
      t.integer :verbal
      t.integer :reliability
      t.integer :timeliness
      t.integer :maturity
      t.integer :skill
      t.integer :commitment
      t.integer :independent

      t.timestamps
    end
  end
end
