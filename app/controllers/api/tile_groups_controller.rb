require 'csv'


class Api::TileGroupsController < ApplicationController
  before_action :set_tile_group, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:csv]

  def csv
    params.require(:csv)

    csv_file = params[:csv]
    counter = 0

    TileGroup.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        TileGroup.create!(row.to_hash)

        counter += 1
        puts counter
      end
    end

    render json: {
        counter: counter,
    }
  end

  # GET /tile_groups
  # GET /tile_groups.json
  def index
    @tile_groups = TileGroup.all
  end

  # GET /tile_groups/1
  # GET /tile_groups/1.json
  def show
  end

  # GET /tile_groups/new
  def new
    @tile_group = TileGroup.new
  end

  # GET /tile_groups/1/edit
  def edit
  end

  # POST /tile_groups
  # POST /tile_groups.json
  def create
    @tile_group = TileGroup.new(tile_group_params)

    respond_to do |format|
      if @tile_group.save
        format.html { redirect_to @tile_group, notice: 'Tile group was successfully created.' }
        format.json { render :show, status: :created, location: @tile_group }
      else
        format.html { render :new }
        format.json { render json: @tile_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tile_groups/1
  # PATCH/PUT /tile_groups/1.json
  def update
    respond_to do |format|
      if @tile_group.update(tile_group_params)
        format.html { redirect_to @tile_group, notice: 'Tile group was successfully updated.' }
        format.json { render :show, status: :ok, location: @tile_group }
      else
        format.html { render :edit }
        format.json { render json: @tile_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tile_groups/1
  # DELETE /tile_groups/1.json
  def destroy
    @tile_group.destroy
    respond_to do |format|
      format.html { redirect_to tile_groups_url, notice: 'Tile group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tile_group
      @tile_group = TileGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tile_group_params
      params.require(:tile_group).permit(:idk, :men, :men_surf, :men_occ5, :men_coll, :men_5ind, :men_1ind, :i_1ind, :men_prop, :i_prop, :men_basr, :i_basr, :ind_r, :ind_age1, :ind_age2, :ind_age3, :ind_age4, :ind_age5, :ind_age6, :ind_age7, :i_age7, :ind_age8, :i_age8, :ind_srf, :nbcar)
    end

    def params_query
      if params[:q].nil?
        render json: {error: "invalid parameters"}, status: 400
      end
    end
end
