require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
