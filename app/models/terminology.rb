class Terminology < ActiveRecord::Base
  belongs_to :job
  attr_accessible :terms
  def get_term
    self
  end
end
