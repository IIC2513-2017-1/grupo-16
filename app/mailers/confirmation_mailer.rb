class ConfirmationMailer < ApplicationMailer
  default from: "rifapp@example.com"

  def confirmed_email(participate)
    @user = User.find(participate.user_id)
    @raffle = Raffle.find(participate.raffle_id)
    @creator = User.find(@raffle.user_id)
    @number = participate.number
    mail(to: @user.email, subject: 'Confirmación de pago')
  end
end
