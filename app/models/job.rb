class Job < ActiveRecord::Base
  attr_accessible :company, :content, :location, :name, :web_source
  has_one :terminology
  def self.grab_topruby
    require 'open-uri'
    count = 0
    source = 'http://toprubyjobs.com'
    doc = Nokogiri::HTML(open(source))
    job_list = Array.new
    c = hs = {first: 1, second: 2, third: 3, fourth: 4} 
    lambda1 = -> { x + 1 }
    doc.css('li.job').each do |job_post|
      unit = Hash.new
      unit[:detail_url] = job_post.css('h4.job-title a').attr('href').value
      unit[:name] = job_post.css('h4.job-title a').text
      unit[:uuid] = unit[:detail_url].slice(/\d+/)
      job_list << unit
    end

    current_uuid_list = Job.where(web_source: 'topruby').pluck(:uuid)
    job_list.each do |job_post|
      unless current_uuid_list.include? job_post[:uuid]
        job = Job.new
        attempts = 0
        begin
          doc = Nokogiri::HTML(open(source + job_post[:detail_url]))
        rescue Exception
          attempts += 1
          retry unless attempts > 2
          exit -1
        ensure
          puts "ensure #{attempts}" 
        end
        job.name = job_post[:name]
        job.uuid = job_post[:uuid]
        job.detail_url = job_post[:detail_url]
        job.company = doc.css('#job dl.meta a').text
        job.location = doc.css('#job dl.meta dd').text
        job.content = doc.css('#job .description').text + "\n" + doc.css('#job .job_instruction').text
        job.web_source = 'topruby'
        job.save
        count += 1
      end
    end
    count
  end
end
