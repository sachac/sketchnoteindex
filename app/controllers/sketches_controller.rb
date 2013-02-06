class SketchesController < ApplicationController
  # GET /sketches
  # GET /sketches.json
  skip_before_filter :authenticate_user!, :only => [:grouped, :index, :show]
  handles_sortable_columns
  autocomplete :artist, :name
  autocomplete :collection, :name
  autocomplete :topic, :name

  def index
    order = sortable_column_order do |column, direction|
      case column
      when "topic"
        "topics.name #{direction}, artists.name #{direction}"
      when "artists.name", "sketches.created_at"
        "#{column} #{direction}"
      else
        "collections.name #{direction}, topics.name #{direction}, artists.name #{direction}"
      end
    end
    @sketches = Sketch.includes(:topic => :collection).includes(:artist).order(order)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sketches }
      format.csv { render csv: @sketches.all }
    end
  end

  # GET /sketches/1
  # GET /sketches/1.json
  def show
    @sketch = Sketch.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sketch }
    end
  end

  # GET /sketches/new
  # GET /sketches/new.json
  def new
    @sketch = Sketch.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sketch }
    end
  end

  # GET /sketches/1/edit
  def edit
    @sketch = Sketch.find(params[:id])
  end

  # POST /sketches
  # POST /sketches.json
  def create
    @sketch = Sketch.process(params[:sketch]) 

    respond_to do |format|
      if @sketch.save
        format.html { redirect_to (!params[:destination].blank? && params[:destination]) || new_sketch_path(nil, params), notice: 'Sketch was successfully created.' }
        format.json { render json: @sketch, status: :created, location: @sketch }
      else
        format.html { render action: "new" }
        format.json { render json: @sketch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sketches/1
  # PUT /sketches/1.json
  def update
    @sketch = Sketch.find(params[:id])
    @sketch.url = params[:sketch][:url]
    old_topic = nil
    old_topic = @sketch.topic.name if @sketch.topic
    
    old_collection = nil
    old_collection = @sketch.topic.collection.name if @sketch.topic and @sketch.topic.collection
    old_artist = nil
    old_artist = @sketch.artist.name if @sketch.artist
    
    if params[:sketch][:conference] != old_collection
      collection = Collection.get_or_create(params[:sketch][:conference])
    else
      collection = @sketch.topic.collection if @sketch.collection
    end
    if params[:sketch][:topic] != old_topic
      topic = Topic.get_or_create(params[:sketch][:conference], collection)
    else
      topic.collection = collection
      topic.save!
    end
    if params[:sketch][:artist] != old_artist
      artist = Artist.get_or_create(params[:sketch][:artist])
    end
    @sketch.topic = topic
    @sketch.artist = artist
    respond_to do |format|
      if @sketch.save
        format.html { redirect_to @sketch, notice: 'Sketch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sketch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sketches/1
  # DELETE /sketches/1.json
  def destroy
    @sketch = Sketch.find(params[:id])
    @sketch.destroy

    respond_to do |format|
      format.html { redirect_to sketches_url }
      format.json { head :no_content }
    end
  end
end
