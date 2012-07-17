class Review < ActiveRecord::Base
  belongs_to :job
  attr_accessible :applied, :memo, :rank
end
