class Job < ActiveRecord::Base
  attr_accessible :company, :content, :location, :name, :web_source

  def self.grab_monster
    require 'open-uri'
    count = 0
    source = 'http://jobsearch.monster.com/search/rails_5?pg='
    doc = Nokogiri::HTML(open(source))
    job_list = Array.new
    page_count = doc.css('.box').count
    page_count.times do |n|
      doc.css('.jobTitleCol .fnt4').each do |job_post|
        unit = Hash.new
        unit[:detail_url] = job_post.css('.jobTitleContainer a').attr('href').value
        unit[:name] = job_post.css('.jobTitleContainer a').text
        unit[:uuid] = unit[:detail_url].slice(/\d+/)
        job_list << unit
      end
      doc = Nokogiri::HTML(open(source + (n+1).to_s))
    end

    current_uuid_list = Job.where(web_source: 'monster').pluck(:uuid)
    job_list.each do |job_post|
      # TODO: The UUID might require a string
      unless current_uuid_list.include? job_post[:uuid].to_i
        job = Job.new
        attempts = 0
        begin
          doc = Nokogiri::HTML(open(job_post[:detail_url]))

          job.name = job_post[:name]
          job.uuid = job_post[:uuid]
          job.detail_url = job_post[:detail_url]

          # Code to fetch the company name
          company_name = nil
          doc.css('script').each do |elem|
            company_name = elem.content.scan(/TrackingCompany: '(.*)'/)
            break if company_name.size > 0
          end

          job.company = company_name.first.first
          companies = Hash.new
          companies["Winter, Wyman"] = ["doc.css('#info td')[9].content'", "doc.css('#TrackingJobBody').content"]
          companies["CyberCoders"] = ["doc.css('#TrackingJobBody .purple-section td')[2].content","doc.css('.description p').text"]
          companies["CIBER, Inc."] = ["remove_unicode(doc.css('#TrackingJobBody font')[3].content.scan(/Location:(.*)/).first.first)", "doc.css('#ejb_templateBody table')[3].content"]
          companies["The Judge Group"] = ["doc.css('#je-positing-info li')[1].content.scan(/Location:(.*)/).first.first.strip", "doc.css('#jobBodyContent').text"] 

          job.location = eval(companies[job.company][0]) rescue nil
          job.content = eval(companies[job.company][1]) rescue nil

          job.web_source = 'monster'
          job.save
          count += 1
        rescue Exception
          p 
          attempts += 1
          retry unless attempts > 2
          #exit -1
        ensure
          puts "ensure #{attempts}" 
        end
      end
    end
  end

  def self.remove_unicode(non_ascii_string)
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
    }
    non_ascii_string.encode(Encoding.find('ASCII'), encoding_options).strip
  end

  def self.grab_topruby
    require 'open-uri'
    count = 0
    source = 'http://toprubyjobs.com'
    doc = Nokogiri::HTML(open(source))
    job_list = Array.new
    doc.css('li.job').each do |job_post|
      unit = Hash.new
      unit[:detail_url] = job_post.css('h4.job-title a').attr('href').value
      unit[:name] = job_post.css('h4.job-title a').text
      unit[:uuid] = unit[:detail_url].slice(/\d+/)
      job_list << unit
    end

    current_uuid_list = Job.where(web_source: 'topruby').pluck(:uuid)
    job_list.each do |job_post|
      # TODO: The UUID might require a string
      unless current_uuid_list.include? job_post[:uuid].to_i
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
