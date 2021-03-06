class CollectionsController < ApplicationController
  # GET /collections
  # GET /collections.json
#  caches_page :index
  def index
    if request.format == :html
      sketches = Sketch.includes(:topic => :collection).includes(:artist).order("collections.name, topics.name, artists.name")
      @by_collection = Hash.new { |h,k| h[k] = Hash.new { |h2,k2| h2[k2] = Array.new }}
      @artists = Hash.new { |h,k| h[k] = Hash.new }
      sketches.each do |sketch|
        collection = sketch.topic && sketch.topic.collection
        topic = sketch.topic
        @by_collection[collection][topic] << sketch
        @artists[collection][sketch.artist] = sketch.artist
      end
    else
      @collections = Collection.order('name')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @collection = Collection.find(params[:id])
    @sketches = @collection.sketches.includes(:topic).includes(:artist).order('topics.name, artists.name')
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.json
  def new
    @collection = Collection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/1/edit
  def edit
    @collection = Collection.find(params[:id])
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { render action: "new" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /collections/1
  # PUT /collections/1.json
  def update
    @collection = Collection.find(params[:id])
    expire_front


    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url }
      format.json { head :no_content }
    end
  end
end
