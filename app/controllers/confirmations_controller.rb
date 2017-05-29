class ConfirmationsController < ApplicationController
  before_action :set_raffle, only: [:show, :confirm]
  before_action :set_participants, only: [:show]

  def show
  end

  def confirm
    @participate = Participate.find(params[:participate_id])
    @participate.update(confirmed: true)

    respond_to do |format|
      if @participate.save
        ConfirmationMailer.confirmed_email(User.find(@participate.user_id), User.find(@raffle.user_id)).deliver!
        format.html { redirect_to raffle_confirmations_path(params[:raffle_id]), notice: 'Pago Confirmado!' }
      else
        format.html { redirect_to raffle_confirmations_path(params[:raffle_id]), notice: 'Error al confirmar pago' }
      end
    end
  end

  private

  def set_raffle
    @raffle = Raffle.find(params[:raffle_id])
  end

  def set_participants
    @participants = Participate.where("raffle_id = ?", params[:raffle_id])
  end
end
