require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  context "Dashboard" do
    should "show the last interval" do
      @interval = Factory(:interval)
      get :index
      assert_response :success
      assert_equal assigns(:interval), @interval
    end
    
    should "show intervals since the last interval"

    should "show intervals since the first activity if there is no last interval" do
      @activity = Factory(:activity)
      get :index
      assert_response :success
      assert_equal assigns(:activity), @activity      
    end

    should "show a welcome message if there is no last interval"
  end
end
