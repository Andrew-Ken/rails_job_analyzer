class Review < ActiveRecord::Base
  RANKS = [['excellent', 0], ['extreme', 1], ['awesome', 2], ['well', 3], ['awful', 4]]
  belongs_to :job
  attr_accessible :applied, :memo, :rank
end
