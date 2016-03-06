class HomeController < ApplicationController
  before_action :user_must_not_sign_in

  def index
  end

def indexjson
  str = {"message" => "hello World"}
  render :json => str
end





end
