require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase

  def setup
    @subject = subjects(:math)
  end

  test "should get show" do
    get :show, id: @subject
    assert_response :success
  end

end
