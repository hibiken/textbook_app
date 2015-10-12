require 'test_helper'

class TextbooksEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:ken)
    @other_user = users(:peizhi)
    @ror        = textbooks(:ruby_on_rails_tutorial)
    log_in_as @user
  end

  test "should successfully edit an existing listing" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", edit_textbook_path(@ror)
    get edit_textbook_path(@ror)
    patch textbook_path(@ror), textbook: { title: @ror.title, price: 100.00 }
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    assert_match /\$100.00/, response.body
  end

  test "unseccessful edit" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", edit_textbook_path(@ror)
    get edit_textbook_path(@ror)
    patch textbook_path(@ror), textbook: { title: '', price: 100.00 }
    assert_template 'textbooks/edit'
    assert_select 'div#error_explanation'
  end

  test "edit link should not show in other users show page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a[href=?]', edit_textbook_path(@ror)
    assert_select 'a', text: 'Edit'
    get user_path(@other_user)
    assert_select 'a', text: 'Edit', count: 0
  end
end
