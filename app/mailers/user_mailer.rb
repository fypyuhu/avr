class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://162.243.207.6/user/sign_in'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
