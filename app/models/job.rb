class Job < ActiveRecord::Base
  attr_accessible :company, :content, :location, :name, :web_source, :uuid, :detail_url
  has_many :terminologies
  has_many :white_job_lists, through: :terminologies
  has_many :reviews
  SOFPAGE = 2

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
          attempts += 1
          retry unless attempts > 2
          exit(-1)
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

  def self.grab_rubyinside
    require 'open-uri'
    parent_url = 'http://jobs.rubyinside.com'
    source = "#{parent_url}/a/jbb/find-jobs"
    doc = Nokogiri::HTML(open(source))
    current_uuid_list = Job.where(web_source: 'rubyinside').pluck(:uuid)

    unit = Hash.new
    doc.css('tr.listing').each_with_index do |job_post,index|
      if(index%2 == 0)

        unit[:detail_url] = job_post.css('.title a').attr('href').value
        #unit[:detail_url] = "#{parent_url}#{unit[:detail_url]}" unless unit[:detail_url].include?(parent_url)

        unit[:name] = job_post.css('.title').text
        unit[:company] = job_post.css('.company').text
        unit[:location] = job_post.css('.location').text
        unit[:uuid] = if(unit[:detail_url].include?('cjp')) 
                        splits = unit[:detail_url].split('/')
                        splits[splits[-2].include?('cjp') ? -2 : -1].slice(/\d+/) 
                      else
                        unit[:detail_url].split('/')[-1]
                      end

      elsif !current_uuid_list.include? unit[:uuid].to_i
        job = Job.new
        job.name = unit[:name]
        job.uuid = unit[:uuid]

        begin
          doc = Nokogiri::HTML(open(source + unit[:detail_url]))
        rescue Exception
          attempts += 1
          retry unless attempts > 2
          exit(-1)
        ensure
          puts "ensure #{attempts}" 
        end
        websites = Hash.new
        websites[unit[:detail_url]]='doc.css(".jam_body_text").text'
        websites['www.simplyhired.com']='doc.css("#lblDescription").text'


        website = unit[:detail_url].split('/')[2]
        unit[:content] = if(websites.has_key?website)
                           eval websites[website]
                         else
                           job_post.css('.details').text
                         end

        job.detail_url = unit[:detail_url]
        job.company = unit[:company]
        job.location = unit[:location]
        job.content = unit[:content]
        job.web_source = 'rubyinside'
        job.save

        unit = Hash.new
      end
    end
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
          exit(-1)
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

  def self.grab_sof
    count = 0
    require "open-uri"
    job_list = []
    SOFPAGE.times.each do |page|
      doc = Nokogiri::HTML(open('http://careers.stackoverflow.com/jobs?searchTerm=ruby&location=new+york&pg=' + (page + 1).to_s))
      doc.css('div#jobslist.main .job').each do |job_post|
        unit = Hash.new
        unit[:detail_url] = 'http://careers.stackoverflow.com' + job_post.css('a.title').attr('href').value.to_s
        unit[:name]       = job_post.css('a.title').attr('title').value
        unit[:company]    = job_post.css('p.employer').attr('title').value
        unit[:uuid]       = job_post.attr('data-jobid')
        unit[:location]   = job_post.css('p.location').text.delete("\r\n\t ")
        job_list << unit
      end
    end

    current_uuid_list = Job.where(web_source: 'stackoverflow').pluck(:uuid)
    job_list.each do |job_post|
      unless current_uuid_list.include? job_post[:uuid].to_i
        attempts = 0
        begin
          doc = Nokogiri::HTML(open(job_post[:detail_url]))
        rescue Exception
          attempts += 1
          retry unless attempts > 2
          exit(-1)
        ensure 
          puts "ensure #{attempts}" 
        end
        Job.create(
          name:        job_post[:name],
          detail_url:  job_post[:detail_url],
          uuid:        job_post[:uuid],
          location:    job_post[:location],
          company:     job_post[:company],
          web_source:  'stackoverflow',
          content:     doc.css('.jobdetail').to_html
        )
        count += 1
      end
    end
    count
  end

  def get_terms
    self.terms = nil
    self.save
    self.terminologies.destroy_all

    WhiteJobList.all.each do |white|
      if !self.content.blank? and self.content.downcase.include? white.name
        self.white_job_lists << white
        if self.terms.blank?
          self.terms = white.name
          self.save
        else
          self.terms += "|#{white.name}"
            self.save
        end
      end
    end
  end

  # Get all terms creates terms for all the Jobs added
  def self.get_all_terms
    all.each{|x| x.get_terms}
  end

end
