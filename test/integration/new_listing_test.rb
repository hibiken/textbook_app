require 'test_helper'

class NewListingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user    = users(:ken)
    @subject = subjects(:computer_science)
    @course  = courses(:CSC221) 
    log_in_as @user
  end

  test "successful new listing" do
    get new_textbook_path
    assert_template 'textbooks/new'
    post textbooks_path, textbook: { title: "Intro to CS", price: 50.00, subject_id: @subject.id, description: "This is great", course_id: @course.id }
    assert_redirected_to @user
    follow_redirect!
    assert_match /Intro to CS/i, response.body
    assert_match /\$50.00/, response.body
    # New listing is showing in correct subject show page
    get subject_path(@subject)
    assert_template 'subjects/show'
    assert_match /Intro to CS/i, response.body
  end

  test "unsuccessful listing" do
    get new_textbook_path
    assert_template 'textbooks/new'
    post textbooks_path, textbook: { title: '', price: -30, subject_id: @subject.id, course_id: @course.id }
    assert_template 'textbooks/new'
    assert_select 'div#error_explanation'
    get user_path(@user.id)
    assert_template 'users/show'
    assert_select 'h3', text: 'Intro to CS', count: 0
  end
end
