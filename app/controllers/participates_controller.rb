class ParticipatesController < ApplicationController

  def multi_new
    @taken = Participate.where("raffle_id = ?", params[:raffle_id]).pluck("number")
    print @taken
  end

  def multi_create
    print params[:user_id]
    params[:numbers].each do |n|
      @participate = Participate.new(user_id: params[:user_id], raffle_id: params[:raffle_id], number: n, confirmed: false)
      
      if not @participate.save
        respond_to do |format|
          format.html { redirect_to participating_user_path(params[:user_id]), notice: 'Ocurrió un error y no pudimos inscribir todos tus números.' }
          format.json { render json: @participate.errors, status: :unprocessable_entity }
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to participating_user_path(params[:user_id]), notice: 'Ya estás participando en esta rifa (pago pendiente)!' }
      format.json { render participating_user_path(params[:user_id]), status: :created, location: @participate }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def participate_params
      params.permit(:user_id, :raffle_id, :numbers)
    end
end
