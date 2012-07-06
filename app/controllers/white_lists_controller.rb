
class WhiteListsController < ApplicationController
  # GET /white_lists
  # GET /white_lists.json
  def index
    @white_lists = WhiteList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @white_lists }
    end
  end

  # GET /white_lists/1
  # GET /white_lists/1.json
  def show
    @white_list = WhiteList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @white_list }
    end
  end

  # GET /white_lists/new
  # GET /white_lists/new.json
  def new
    @white_list = WhiteList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @white_list }
    end
  end

  # GET /white_lists/1/edit
  def edit
    @white_list = WhiteList.find(params[:id])
  end

  # POST /white_lists
  # POST /white_lists.json
  def create
    @white_list = WhiteList.new(params[:white_list])

    respond_to do |format|
      if @white_list.save
        format.html { redirect_to @white_list, notice: 'White list was successfully created.' }
        format.json { render json: @white_list, status: :created, location: @white_list }
      else
        format.html { render action: "new" }
        format.json { render json: @white_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /white_lists/1
  # PUT /white_lists/1.json
  def update
    @white_list = WhiteList.find(params[:id])

    respond_to do |format|
      if @white_list.update_attributes(params[:white_list])
        format.html { redirect_to @white_list, notice: 'White list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @white_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /white_lists/1
  # DELETE /white_lists/1.json
  def destroy
    @white_list = WhiteList.find(params[:id])
    @white_list.destroy

    respond_to do |format|
      format.html { redirect_to white_lists_url }
      format.json { head :no_content }
    end
  end
end
