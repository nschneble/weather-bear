class LookupsController < ApplicationController
  before_action :set_lookup, only: %i[ show edit update destroy ]
  before_action :set_zip_code_from_query, only: %i[ create ]
  before_action :set_lookup_from_zip_code, only: %i[ create ]
  before_action :query_weather_api, only: %i[ create ]

  # GET /lookups or /lookups.json
  def index
    @lookups = Lookup.all
  end

  # GET /lookups/1 or /lookups/1.json
  def show
  end

  # GET /lookups/new
  def new
    @lookup = Lookup.new
  end

  # GET /lookups/1/edit
  def edit
  end

  # POST /lookups or /lookups.json
  def create
    # checks if we already have a recently cached lookup to display
    if @lookup.present?
      respond_to do |format|
        format.html { redirect_to lookup_url(@lookup), notice: "These weather conditions were last updated #{helpers.time_ago_in_words(@lookup.cached_at)} ago" }
        format.json { render :show, status: :ok, location: @lookup }
      end
    else
      @lookup = Lookup.new(lookup_params)

      respond_to do |format|
        if @lookup.save
          format.html { redirect_to lookup_url(@lookup) }
          format.json { render :show, status: :created, location: @lookup }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @lookup.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /lookups/1 or /lookups/1.json
  def update
    respond_to do |format|
      if @lookup.update(lookup_params)
        format.html { redirect_to lookup_url(@lookup), notice: "Lookup was successfully updated." }
        format.json { render :show, status: :ok, location: @lookup }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lookups/1 or /lookups/1.json
  def destroy
    @lookup.destroy!

    respond_to do |format|
      format.html { redirect_to lookups_url, notice: "Lookup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lookup
      @lookup = Lookup.find(params[:id])
    end

    def set_zip_code_from_query
      query = params[:query]

      unless helpers.query_is_zip_code(query)
        params[:query] = helpers.lookup_zip_code_params_from_query(query)
      end

      unless helpers.query_is_zip_code(params[:query])
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Sorry, but we couldn't make sense of that address. Try again?" }
          format.json { render json: @lookup.errors, status: :unprocessable_entity }
        end
      end
    end

    def set_lookup_from_zip_code
      zip_code = params[:query]
      scale = params[:scale]

      @lookup = Lookup.find_by("zip_code = ? AND scale = ? AND cached_at > ?", zip_code, scale, 30.minutes.ago)
    end

    # Uses WeatherAPI.com to lookup weather based on the search query
    def query_weather_api
      # skips if we already have a recently cached lookup to display
      unless @lookup.present?
        zip_code = params[:query]
        scale = params[:scale]

        params[:lookup] = helpers.supply_lookup_params_from_weather_query(zip_code, scale)
      end
    end

    # Only allow a list of trusted parameters through.
    def lookup_params
      params.require(:lookup).permit(:zip_code, :cached_at, :scale, :temperature, :high, :low, :condition, :icon)
    end
end
