class UserController < ApplicationController
  before_action :authenticate_user!
  layout "userpanel"

  def index
    UserMailer.welcome_email(@user).send

  end
  def myvideos

    end




end
