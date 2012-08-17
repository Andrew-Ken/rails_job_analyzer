
class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  def chart
    @categories = ['April','May', 'June', 'July', 'August']#WightJobList.plucki(:name)
    @series = [{
      type: 'column',
      name: 'git',
      data: [3, 2, 1, 3, 4]
    }, {
      type: 'column',
      name: 'jquery',
      data: [2, 3, 5, 7, 6]
    }, {
      type: 'column',
      name: 'rspec',
      data: [4, 3, 3, 9, 0]
    }, {
      type: 'spline',
      name: 'Average',
      data: [3, 2.67, 3, 6.33, 3.33]
    }, {
      type: 'pie',
      name: 'Total consumption',
      data: [{
        name: 'git',
        y: 13,
        color: '#4572A7' # Jane's color
      }, {
        name: 'jquery',
        y: 23,
        color: '#AA4643' # John's color
      }, {
        name: 'rspec',
        y: 19,
        color: '#89A54E' # Joe's color
      }],
      center: [100, 80],
      size: 100,
      showInLegend: false,
      dataLabels: {
        enabled: false
      }
    }].to_json   
    @jobs = Job.all
    respond_to do |format|
      format.html
      format.json {render json: @jobs}
    end
  end


  def review
    @jobs = Job.all
    respond_to do |format|
      format.html
      format.json {render json: @jobs}
    end
  end
  
  def rank
    id   = params[:id].to_i
    rank = params[:rank].to_i 
    @job = Job.find_by_id(id)
    #TODO need to refact proper
    rev = Review.where(job_id: @job.id, user_id: session[:user_id]).first
    if(rev.blank?)
      Review.create(job_id: @job.id, rank: rank, user_id: session[:user_id]) 
    else
      rev.rank = rank
      rev.save
    end
    render text: Review::RANKS[params[:rank].to_i][0]
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
end
