require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title,         'Textbook App'
    assert_equal full_title('Help'), 'Help | Textbook App'
  end
end