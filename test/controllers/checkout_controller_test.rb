require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  test "should get receipt" do
    get :receipt
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

end
