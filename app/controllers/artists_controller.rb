class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.json
  handles_sortable_columns
  caches_page :index
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "count"
        "3 #{direction}"
      else
        "name #{direction}"
      end
    end

    @artists = Artist.select('artists.id, name, count(sketches.id)').joins(:sketches).group('artists.id').order(order)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id])
    @sketches = @artist.sketches.includes(:topic => :collection).order('collections.name, topics.name')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/new
  # GET /artists/new.json
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(params[:artist])
    expire_page :action => :index

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "new" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])
    expire_page :action => :index
    expire_page :controller => :sketches, :action => :index
    expire_page :controller => :collection, :action => :index

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    expire_page :action => :index
    expire_page :controller => :sketches, :action => :index
    expire_page :controller => :collection, :action => :index

    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end
end
