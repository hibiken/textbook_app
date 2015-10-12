require 'test_helper'

class TextbooksEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:ken)
    @other_user = users(:peizhi)
    @ror        = textbooks(:ruby_on_rails_tutorial) # this textbook belongs to @user.
  end

  test "should successfully edit an existing listing" do
    log_in_as @user
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
    log_in_as @user
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", edit_textbook_path(@ror)
    get edit_textbook_path(@ror)
    patch textbook_path(@ror), textbook: { title: '', price: 100.00 }
    assert_template 'textbooks/edit'
    assert_select 'div#error_explanation'
  end

  test "edit link should not show in other users show page" do
    log_in_as @user
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a[href=?]', edit_textbook_path(@ror)
    assert_select 'a', text: 'Edit'
    get user_path(@other_user)
    assert_select 'a', text: 'Edit', count: 0
  end

  test "successful destroy" do
    log_in_as @user
    get user_path(@user.id)
    assert_select 'a', method: :delete
    assert_difference 'Textbook.count', -1 do
      delete textbook_path(@ror)
    end
    assert_redirected_to user_path(@user.id)
  end

  test "should redirect update when not logged in" do
    patch textbook_path(@ror), textbook: { title: @ror.title, price: 100.00 }
    assert_redirected_to login_url
  end

  test "user cannot edit, delete other users listing" do
    log_in_as @other_user
    patch textbook_path(@ror), textbook: { title: @ror.title, price: 100.00 }
    assert_redirected_to root_url
    delete textbook_path(@ror)
    assert_redirected_to root_url
  end
end
