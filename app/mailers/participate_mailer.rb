class ParticipateMailer < ApplicationMailer
  default from: "rifapp@example.com"

  def new_participate_email(user, buyer, r_id)
    @user = user
    @buyer = buyer
    @r_id = r_id
    mail(to: @user.email, subject: 'Alguien quiere participar de tu rifa!')
  end
end
