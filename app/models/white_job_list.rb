class WhiteJobList < ActiveRecord::Base
  has_many :terminologies
  has_many :jobs, through: :terminologies
  attr_accessible :name
end
