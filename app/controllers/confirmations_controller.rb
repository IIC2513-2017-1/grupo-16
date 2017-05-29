class ConfirmationsController < ApplicationController
  before_action :set_raffle, only: [:show, :generate_winner, :confirm]
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

  def generate_winner
    confirmed_participants = Participate.where("raffle_id = ? AND confirmed = true", params[:raffle_id])
    winner_participant_array = confirmed_participants.sample(1)
    winner_participant = winner_participant_array[0]
    @raffle.update(winner_id: winner_participant.user_id)

    respond_to do |format|
      if @raffle.save
        format.html { redirect_to created_user_path(current_user.id), notice: 'Rifa Sorteada!' }
      else
        format.html { redirect_to created_user_path(current_user.id), notice: 'Error al sortear rifa' }
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
