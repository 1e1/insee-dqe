require 'csv'


class Api::TilesController < ApplicationController
  before_action :params_query, only: [:search]
  before_action :set_tile, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:csv]

  def search
=begin
    tile = Tile
               .where('longitude_min <= ?', params[:longitude])
               .where('? < longitude_max', params[:longitude])
               .where('latitude_min <= ?', params[:latitude])
               .where('? < latitude_max', params[:latitude])
               .first
=end

    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    point   = factory.point(params[:longitude], params[:latitude])

    tile = Tile.containing(point).first

    if tile.nil?
      render json: {}
    else
      tile_group = tile.tile_group

      population_total_from65to74yearsold = tile_group.ind_age7 - tile_group.ind_age8 # 75+
      population_total_from25to64yearsold = tile_group.ind_age6 - tile_group.ind_age7 # 65+
      population_total_from18to24yearsold = tile_group.ind_r - # all
        tile_group.ind_age6 - # 25+
        tile_group.ind_age5 - # 15-17
        tile_group.ind_age4 - # 11-14
        tile_group.ind_age3 - # 6-10
        tile_group.ind_age2 - # 4-5
        tile_group.ind_age1   # 0-3

      render json: {
          id:  tile.id,
          population: tile.ind_c,
          household_number: tile_group.men,
          household_surface: tile_group.men_surf,
          household_number_since5years: tile_group.men_occ5,
          household_number_inblock: tile_group.men_coll,
          household_number_greaterthan5persons: tile_group.men_5ind,
          household_number_is1person: tile_group.men_1ind,
          has_household_number_is1person: tile_group.i_1ind.to_i,
          household_number_owner: tile_group.men_prop,
          has_household_number_owner: tile_group.i_prop.to_i,
          household_number_poor: tile_group.men_basr,
          has_household_number_poor: tile_group.i_basr.to_i,
          population_total: tile_group.ind_r,
          population_total_from0to3yearsold: tile_group.ind_age1,
          population_total_from4to5yearsold: tile_group.ind_age2,
          population_total_from6to10yearsold: tile_group.ind_age3,
          population_total_from11to14yearsold: tile_group.ind_age4,
          population_total_from15to17yearsold: tile_group.ind_age5,
          population_total_from18to24yearsold: population_total_from18to24yearsold,
          population_total_from25to64yearsold: population_total_from25to64yearsold,
          population_total_from65to74yearsold: population_total_from65to74yearsold,
          population_total_greaterthan75yearsold: tile_group.ind_age8,
          has_population_total_from65to74yearsold: tile_group.i_age7.to_i,
          has_population_total_greaterthan75yearsold: tile_group.i_age8.to_i,
          earnings_total: tile_group.ind_srf,

          shape: {
              longitude_min: tile.longitude_min,
              longitude_max: tile.longitude_max,
              latitude_min: tile.latitude_min,
              latitude_max: tile.latitude_max,
          }
      }
    end
  end

  def csv
    params.require(:csv)

    csv_file = params[:csv]
    counter = 0

    Tile.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        Tile.create!(row.to_hash)

        counter += 1
        puts counter
      end
    end

    render json: {
        counter: counter,
    }
  end

  # GET /tiles
  # GET /tiles.json
  def index
    @tiles = Tile.all
  end

  # GET /tiles/1
  # GET /tiles/1.json
  def show
  end

  # GET /tiles/new
  def new
    @tile = Tile.new
  end

  # GET /tiles/1/edit
  def edit
  end

  # POST /tiles
  # POST /tiles.json
  def create
    @tile = Tile.new(tile_params)

    respond_to do |format|
      if @tile.save
        format.html { redirect_to @tile, notice: 'Tile was successfully created.' }
        format.json { render :show, status: :created, location: @tile }
      else
        format.html { render :new }
        format.json { render json: @tile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiles/1
  # PATCH/PUT /tiles/1.json
  def update
    respond_to do |format|
      if @tile.update(tile_params)
        format.html { redirect_to @tile, notice: 'Tile was successfully updated.' }
        format.json { render :show, status: :ok, location: @tile }
      else
        format.html { render :edit }
        format.json { render json: @tile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiles/1
  # DELETE /tiles/1.json
  def destroy
    @tile.destroy
    respond_to do |format|
      format.html { redirect_to tiles_url, notice: 'Tile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tile
      @tile = Tile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tile_params
      params.require(:tile).permit(:id, :idINSPIRE, :idk, :ind_c, :nbcar)
    end

    def params_query
      if params[:longitude].nil?
        render json: {error: "invalid parameters"}, status: 400
      end

      if params[:latitude].nil?
        render json: {error: "invalid parameters"}, status: 400
      end
    end
end
