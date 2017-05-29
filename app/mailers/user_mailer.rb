class UserMailer < ApplicationMailer
  default from: "rifapp@example.com"

  def new_user_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenido a Rifapp!')
  end
end
