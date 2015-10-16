require 'test_helper'

class CommentCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user     = users(:ken)
    @textbook = textbooks(:supply_chain_management)
  end

  test "comment text area should not show when not logged in" do
    get textbook_path(@textbook)
    assert_template 'textbooks/show'
    assert_no_match /leave a comment/i, response.body
    assert_select 'textarea', count: 0
  end

  test "comment text area should show when logged in" do
    log_in_as @user 
    get textbook_path(@textbook)
    assert_template 'textbooks/show'
    assert_match /leave a comment/i, response.body
    assert_select 'textarea'
  end

  test "logged in user should be able to post a comment" do
    log_in_as @user
    get textbook_path(@textbook)
    post comment_path comment: { message: "I would like to buy your textbook", textbook_id: @textbook.id }
    assert_redirected_to textbook_url(@textbook)
    follow_redirect!
    assert_match /I would like to buy your textbook/i, response.body
  end
end
