require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get embeds" do
    get :embeds
    assert_response :success
  end

  test "should get walls" do
    get :walls
    assert_response :success
  end

  test "should get studs" do
    get :studs
    assert_response :success
  end

  test "should get columns" do
    get :columns
    assert_response :success
  end

end
