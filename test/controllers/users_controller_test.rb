require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

  test "should get order_status" do
    get :order_status
    assert_response :success
  end

end
