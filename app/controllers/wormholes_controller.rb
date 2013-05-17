# encoding: UTF-8
class WormholesController < ApplicationController
  # GET /wormholes
  # GET /wormholes.json
  def index
    if params[:name]
      redirect_to '/wormholes/'+params[:name]
      return
    end
    @lac = Comment.sort(:created_at.desc).where(:commentable_type => 'Wormhole').limit(20)
    @infos = Info.sort(:created_at.desc).all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  

  def q
    name = params[:name].upcase
    @whs = Wormhole.where(:name => /^#{name}/).fields(:name).all
    respond_to do |format|
      format.json {render json: @whs }
    end
  end

  def comment
    @wh = Wormhole.find_by_name(params[:id].upcase)
    @wh.comments.create(body: params[:body])
    redirect_to "/wormholes/#{params[:id]}"
  end

  # GET /wormholes/1
  # GET /wormholes/1.json
  def show
    @wh = Wormhole.find_by_name(params[:id].upcase)
    if (not @wh)
      @error = true
    elsif (@wh.planets.count == 0) or (params[:forceclear])
      @wh.planets.clear
      @wh.get_info
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wh }
    end
  end

  # GET /wormholes/new
  # GET /wormholes/new.json
  def new
    @wormhole = Wormhole.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wormhole }
    end
  end

  # GET /wormholes/1/edit
  def edit
    @wormhole = Wormhole.find_by_name(params[:id].upcase)
  end

  # POST /wormholes
  # POST /wormholes.json
  def create
    @wormhole = Wormhole.new(params[:wormhole])

    respond_to do |format|
      if @wormhole.save
        format.html { redirect_to "/wormholes/#{@wormhole.name}", notice: 'Wormhole was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /wormholes/1
  # PUT /wormholes/1.json
  def update
    @wormhole = Wormhole.find(params[:id])

    respond_to do |format|
      if @wormhole.update_attributes(params[:wormhole])
        format.html { redirect_to "/wormholes/#{@wormhole.name}", notice: 'Wormhole was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /wormholes/1
  # DELETE /wormholes/1.json
  def destroy
    @wormhole = Wormhole.find(params[:id])
    @wormhole.destroy

    respond_to do |format|
      format.html { redirect_to wormholes_url }
      format.json { head :no_content }
    end
  end
end
