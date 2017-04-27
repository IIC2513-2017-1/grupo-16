class SorteosController < ApplicationController
  before_action :set_sorteo, only: [:show, :edit, :update, :destroy]

  # GET /sorteos
  # GET /sorteos.json
  def index
    @sorteos = Sorteo.all
  end

  # GET /sorteos/1
  # GET /sorteos/1.json
  def show
  end

  # GET /sorteos/new
  def new
    @sorteo = Sorteo.new
  end

  # GET /sorteos/1/edit
  def edit
  end

  # POST /sorteos
  # POST /sorteos.json
  def create
    @sorteo = Sorteo.new(sorteo_params)

    respond_to do |format|
      if @sorteo.save
        format.html { redirect_to @sorteo, notice: 'Sorteo was successfully created.' }
        format.json { render :show, status: :created, location: @sorteo }
      else
        format.html { render :new }
        format.json { render json: @sorteo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sorteos/1
  # PATCH/PUT /sorteos/1.json
  def update
    respond_to do |format|
      if @sorteo.update(sorteo_params)
        format.html { redirect_to @sorteo, notice: 'Sorteo was successfully updated.' }
        format.json { render :show, status: :ok, location: @sorteo }
      else
        format.html { render :edit }
        format.json { render json: @sorteo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sorteos/1
  # DELETE /sorteos/1.json
  def destroy
    @sorteo.destroy
    respond_to do |format|
      format.html { redirect_to sorteos_url, notice: 'Sorteo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sorteo
      @sorteo = Sorteo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sorteo_params
      params.fetch(:sorteo, {})
    end
end
