class ConfirmationMailer < ApplicationMailer
  default from: "rifapp@example.com"

  def confirmed_email(user, creator)
    @user = user
    @creator = creator
    mail(to: @user.email, subject: 'Confirmación de pago')
  end
end
