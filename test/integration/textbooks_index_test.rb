require 'test_helper'

class TextbooksIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ken)
    log_in_as @user
  end

  test "successful listing showing in index page" do
    get new_textbook_path
    assert_template 'textbooks/new'
    assert_difference 'Textbook.count', 1 do
      post textbooks_path, textbook: { title: "Microeconomics", price: 120.00, subject_id: 1, description: "This is awesome" }
    end
    assert_redirected_to user_path(@user.id)
    follow_redirect!
    assert_not flash.empty?
    get textbooks_path
    assert_template 'textbooks/index'
    assert_match /Microeconomics/i, response.body
  end

  test "unsuccessful listing not showing in index page" do
    get new_textbook_path
    assert_template 'textbooks/new'
    assert_no_difference 'Textbook.count' do
      post textbooks_path, textbook: { title: 'Macroeconomics', price: 'one hundred dollars' }
    end
    assert_template 'textbooks/new'
    assert_select 'div#error_explanation'
    get textbooks_path
    assert_template 'textbooks/index'
    assert_no_match /Macroeconomics/i, response.body
  end
end
