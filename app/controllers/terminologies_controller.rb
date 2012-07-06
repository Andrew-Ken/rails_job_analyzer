
class TerminologiesController < ApplicationController
  # GET /terminologies
  # GET /terminologies.json
  def index
    @terminologies = Terminology.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @terminologies }
    end
  end

  # GET /terminologies/1
  # GET /terminologies/1.json
  def show
    @terminology = Terminology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @terminology }
    end
  end

  # GET /terminologies/new
  # GET /terminologies/new.json
  def new
    @terminology = Terminology.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @terminology }
    end
  end

  # GET /terminologies/1/edit
  def edit
    @terminology = Terminology.find(params[:id])
  end

  # POST /terminologies
  # POST /terminologies.json
  def create
    @terminology = Terminology.new(params[:terminology])

    respond_to do |format|
      if @terminology.save
        format.html { redirect_to @terminology, notice: 'Terminology was successfully created.' }
        format.json { render json: @terminology, status: :created, location: @terminology }
      else
        format.html { render action: "new" }
        format.json { render json: @terminology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /terminologies/1
  # PUT /terminologies/1.json
  def update
    @terminology = Terminology.find(params[:id])

    respond_to do |format|
      if @terminology.update_attributes(params[:terminology])
        format.html { redirect_to @terminology, notice: 'Terminology was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @terminology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terminologies/1
  # DELETE /terminologies/1.json
  def destroy
    @terminology = Terminology.find(params[:id])
    @terminology.destroy

    respond_to do |format|
      format.html { redirect_to terminologies_url }
      format.json { head :no_content }
    end
  end
end
