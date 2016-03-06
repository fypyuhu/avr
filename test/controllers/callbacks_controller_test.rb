require 'test_helper'

class CallbacksControllerTest < ActionController::TestCase
  test "should get digitalocean" do
    get :digitalocean
    assert_response :success
  end

end
