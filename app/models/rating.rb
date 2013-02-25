class Rating < ActiveRecord::Base
  attr_accessible :commitment, :independent, :intellect, :leadership, :maturity, :recommendation_id, :reliability, :skill, :timeliness, :verbal, :written
  belongs_to :recommendation
end
