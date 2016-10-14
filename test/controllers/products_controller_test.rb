require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get products" do
    get :products
    assert_response :success
  end


end
