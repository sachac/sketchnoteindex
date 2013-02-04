class SketchesController < ApplicationController
  # GET /sketches
  # GET /sketches.json
  def index
    @sketches = Sketch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sketches }
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
    @sketch = Sketch.new

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
    @sketch = Sketch.new(params[:sketch])

    respond_to do |format|
      if @sketch.save
        format.html { redirect_to @sketch, notice: 'Sketch was successfully created.' }
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

    respond_to do |format|
      if @sketch.update_attributes(params[:sketch])
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
