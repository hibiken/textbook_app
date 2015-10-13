require 'test_helper'

class SimpleSearchTest < ActionDispatch::IntegrationTest
  
  def setup
    @ror = textbooks(:ruby_on_rails_tutorial)
  end

  test "should search for textbooks with title and display them in index page" do
    get textbooks_path, search: 'Ruby on Rails'
    assert_template 'textbooks/index'
    assert_match @ror.title, response.body
    assert_no_match /no textbooks found/i, response.body
  end

  test "should render textbooks index page with a message if no textbooks are found" do
    get textbooks_path, search: 'DoNotExist'
    assert_template 'textbooks/index'
    textbooks = assigns(:textbooks)
    assert_equal textbooks.size, 0
    assert_match /no textbooks found/i, response.body
  end
end
