require 'test_helper'

class EstimatesControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
