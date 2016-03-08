class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://162.243.207.6/user/index'
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
end
