require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get non_tasker_signup" do
    get :non_tasker_signup
    assert_response :success
  end

end
