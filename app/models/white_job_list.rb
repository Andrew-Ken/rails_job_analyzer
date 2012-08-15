class WhiteJobList < ActiveRecord::Base
  has_many :terminologies
  has_many :jobs, through: :terminologies
  attr_accessible :name

  #Get the data for pie charts
  def self.get_pie_chart_data
    total = Terminology.count
    all.collect do |white|
      [white.name, ((white.jobs.count.to_f*100)/total).round(2)]
    end
  end
end
