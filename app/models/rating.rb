class Rating < ActiveRecord::Base
  attr_accessible :status,:commitment, :independent, :intellect, :leadership, :maturity, :reliability, :skill, :timeliness, :notes, :verbal, :written

  belongs_to :recommendation

  STATUS_COMPLETED = "COMPLETED"
end
