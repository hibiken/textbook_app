require 'test_helper'

class TextbooksControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:ken)
    @subject = subjects(:computer_science)
    @course = courses(:CSC221)
  end

  test "should create a new listing" do
    log_in_as @user
    get :new
    assert_template 'textbooks/new'
    assert_difference 'Textbook.count', 1 do
      post :create, textbook: { title: "Intro to CS", price: 50.00, subject_id: @subject.id, course_id: @course.id, description: "This is really helpful" }
    end
    assert_redirected_to @user
    assert_not flash.empty?
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    post :create, textbook: { title: "Intro to CS", price: 50.00 }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
