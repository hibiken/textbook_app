require 'test_helper'

class NewListingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ken)
    log_in_as @user
  end

  test "successful new listing" do
    get new_textbook_path
    assert_template 'textbooks/new'
    post textbooks_path, textbook: { title: "Intro to CS", price: 50.00, subject_id: 1, description: "This is great" }
    assert_redirected_to @user
    follow_redirect!
    assert_match /Intro to CS/i, response.body
    assert_match /\$50.00/, response.body
  end

  test "unsuccessful listing" do
    get new_textbook_path
    assert_template 'textbooks/new'
    post textbooks_path, textbook: { title: '', price: -30 }
    assert_template 'textbooks/new'
    assert_select 'div#error_explanation'
    get user_path(@user.id)
    assert_template 'users/show'
    assert_select 'h3', text: 'Intro to CS', count: 0
  end
end
