class ContinentsController < ApplicationController
  before_action :set_continent, only: [:show, :edit, :update, :destroy]

  # GET /continents
  # GET /continents.json
  def index
    @continents = Continent.all
  end

  # GET /continents/1
  # GET /continents/1.json
  def show
  end

  # GET /continents/new
  def new
    @continent = Continent.new
  end

  # GET /continents/1/edit
  def edit
  end

  # POST /continents
  # POST /continents.json
  def create
    @continent = Continent.new(continent_params)

    respond_to do |format|
      if @continent.save
        format.html { redirect_to @continent, notice: 'Continent was successfully created.' }
        format.json { render :show, status: :created, location: @continent }
      else
        format.html { render :new }
        format.json { render json: @continent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /continents/1
  # PATCH/PUT /continents/1.json
  def update
    respond_to do |format|
      if @continent.update(continent_params)
        format.html { redirect_to @continent, notice: 'Continent was successfully updated.' }
        format.json { render :show, status: :ok, location: @continent }
      else
        format.html { render :edit }
        format.json { render json: @continent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /continents/1
  # DELETE /continents/1.json
  def destroy
    @continent.destroy
    respond_to do |format|
      format.html { redirect_to continents_url, notice: 'Continent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_continent
      @continent = Continent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def continent_params
      params.fetch(:continent, {})
    end
end
