class ParticipatesController < ApplicationController

  # POST /participates
  # POST /participates.json
  def create
    @participate = Participate.new(participate_params)

    respond_to do |format|
      if @participate.save
        format.html { redirect_to participating_user_path(params[:user_id]), notice: 'Ya estás participando en esta rifa (pago pendiente)!' }
        format.json { render participating_user_path(params[:user_id]), status: :created, location: @participate }
      else
        format.html { render :new }
        format.json { render json: @participate.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def participate_params
      params.permit(:user_id, :raffle_id)
    end
end
