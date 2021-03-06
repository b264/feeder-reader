class ChannelsController < ApplicationController
  # GET /channels
  # GET /
  # GET /refresh
  def index
    if params[:refresh].to_s== 'now'
      params.delete :refresh
      Channel.refresh
    end
    @channels= Channel.all
    @count= Channel.all.count.to_i
    @feed= 'feeds'
    if @count== 1
      @feed= 'feed'
    end
  end
  # GET /channels/1
  def show
    @channel = Channel.find(params[:id])
  end
  # GET /channels/new
  def new
    @channel= Channel.new
  end
  # GET /channels/1/edit
  def edit
    @channel = Channel.find(params[:id])
  end
  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(params[:channel])
    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render json: @channel, status: :created, location: @channel }
      else
        format.html { render action: "new" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end
  # PUT /channels/1
  # PUT /channels/1.json
  def update
    @channel = Channel.find(params[:id])
    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end
  private
  
end
