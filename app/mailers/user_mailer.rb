class UserMailer < ApplicationMailer

  def sample_email(user)
    @user = user
    mail(to: @user.email ,subject: 'Sample Email')
  end

  def seller_email(user)
    @user = user
    mail(to: @user.email ,subject: 'Sampl Email')
  end
end
