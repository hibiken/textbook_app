require 'test_helper'

class MarkAsSoldTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:peizhi)
    @textbook      = textbooks(:supply_chain_management)
    @sold_textbook = textbooks(:sold_textbook)
    @not_mine      = textbooks(:c_programming)
  end

  test "should redirect sold when not logged in" do
    post sold_textbook_path(@textbook)
    assert_redirected_to login_url
    assert_not @textbook.sold?
  end

  test "should redirect sold if trying to mark other people's textbook as sold" do
    log_in_as @user 
    post sold_textbook_path(@not_mine)
    assert_redirected_to root_url
    assert_not @not_mine.sold?
  end

  test "should mark the textbook as sold" do
    log_in_as @user 
    get user_path(@user) 
    assert_match /mark as sold/i, response.body
    post sold_textbook_path(@textbook)
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
    assert @textbook.reload.sold?
  end

  test "should not show 'mark as sold' button on other users profile page" do
    log_in_as @user 
    get user_path(users(:ken))
    assert_template 'users/show'
    assert_no_match /mark as sold/i, response.body
  end  

end
