require 'test_helper'

class BssControllerTest < ActionController::TestCase
  test "should get panel" do
    get :panel
    assert_response :success
  end

end
