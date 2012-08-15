class Terminology < ActiveRecord::Base
  belongs_to :job
  belongs_to :white_job_list
  attr_accessible :terms
  def get_term
    self
  end
end
