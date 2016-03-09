class ArticleController < ApplicationController
  before_action :authenticate_user!
  layout "userpanel"


  def index

  end
end
