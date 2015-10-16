require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 
  def setup
    @user1    = users(:ken)
    @user2    = users(:peizhi)
    @textbook = textbooks(:c_programming)
    @comment = Comment.new(message: "Can I buy this?", user_id: @user2.id, textbook_id: @textbook.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "message should be present" do
    @comment.message = " "
    assert_not @comment.valid?
  end

  test "user_id should be present" do
    @comment.user = nil
    assert_not @comment.valid?
  end

  test "textbook_id should be present" do
    @comment.textbook = nil 
    assert_not @comment.valid?
  end
end
