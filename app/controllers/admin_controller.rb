class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin
  layout "back"
  def index
  end
  def is_admin

  end
end
