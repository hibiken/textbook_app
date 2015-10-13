require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  
  def setup
    @subject = Subject.new(name: "Computer Science")
  end

  test "should be valid" do
    assert @subject.valid?
  end

  test "name should be present" do
    @subject.name = '  '
    assert_not @subject.valid?
  end
end
