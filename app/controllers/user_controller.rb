class UserController < ApplicationController
  before_action :authenticate_user!
  layout "userpanel"

  def index
    @user = current_user
    UserMailer.welcome_email(@user).deliver_later

  end
  def myvideos

    end




end
