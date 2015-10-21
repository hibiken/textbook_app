require 'test_helper'

class LayoutsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ken)
    @textbook = textbooks(:ruby_on_rails_tutorial)
  end

  test "layout for sign up" do
    get new_user_path
    assert_template 'users/new'
    assert_select 'div.sidebar', count: 0
  end

  test 'layout for log in' do
    get login_path
    assert_template 'sessions/new'
    assert_select 'div.sidebar', count: 0
    log_in_as @user
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.sidebar'
  end

  test 'layout for textbooks new and edit' do
    log_in_as @user
    get new_textbook_path
    assert_template 'textbooks/new'
    assert_select 'div.sidebar', count: 0
    get edit_textbook_path(@textbook)
    assert_template 'textbooks/edit'
    assert_select 'div.sidebar', count: 0
  end

  test 'layout for courses new' do
    log_in_as @user
    get new_course_path
    assert_template 'courses/new'
    assert_select 'div.sidebar', count: 0
  end


end
