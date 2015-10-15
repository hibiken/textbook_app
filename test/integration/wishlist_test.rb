require 'test_helper'

class WishlistTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ken)
    @english_101 = courses(:ENG101)
    log_in_as @user 
  end

  test "successful wishlist update" do
    get wishlist_path
    assert_template 'courses/index'
    assert_select 'a[href=?]', new_course_path
    get new_course_path
    assert_template 'courses/new'
    assert_select 'option', text: @english_101.name
    post courses_path, course_id: @english_101.id
    assert_redirected_to wishlist_url
    follow_redirect!
    assert_not flash.empty?
    assert_match @english_101.name, response.body
  end
end
