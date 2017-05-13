class ParticipatesController < ApplicationController
  #TODO: fix participate button

  # GET /participates/1
  # GET /participates/1.json
  def show
  end

  # GET /participates/new
  def new
    @participate = Participate.new
    @raffle = Raffle.find(params[:raffle])
  end

  # POST /participates
  # POST /participates.json
  def create
    @participate = Participate.new(participate_params)

    respond_to do |format|
      if @participate.save
        format.html { redirect_to @participate, notice: 'participate was successfully created.' }
        format.json { render :show, status: :created, location: @participate }
      else
        format.html { render :new }
        format.json { render json: @participate.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def participate_params
      params.require(:participate).permit(:user_id, :raffle_id, :raffle)
    end
end
