require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  
  def setup
    @course = Course.new(name: "ENG 101")
  end

  test "should be valid" do
    assert @course.valid?
  end

  test "name should be present" do
    @course.name = ' '
    assert_not @course.valid?
  end
end
