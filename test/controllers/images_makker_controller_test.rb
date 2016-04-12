require 'test_helper'

class ImagesMakkerControllerTest < ActionController::TestCase
  test "should get heading" do
    get :heading
    assert_response :success
  end

  test "should get paragraph" do
    get :paragraph
    assert_response :success
  end

end
