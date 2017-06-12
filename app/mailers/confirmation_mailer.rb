class ConfirmationMailer < ApplicationMailer
  default from: "rifapp@example.com"

  def confirmed_email(participate)
    @user = User.find(participate.user_id)
    @raffle = Raffle.find(participate.raffle_id)
    @creator = User.find(@raffle.user_id)
    @number = participate.number
    mail(to: @user.email, subject: 'Confirmación de pago')
  end

  def winner_email(raffle)
    @winner = User.find(raffle.winner_id)
    @creator = User.find(raffle.user_id).first_name
    @prize = raffle.prize
    @title = raffle.name
    mail(to: @winner.email, subject: 'GANASTE!')
  end
end
