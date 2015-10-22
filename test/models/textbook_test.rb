require 'test_helper'

class TextbookTest < ActiveSupport::TestCase
  
  def setup
    @textbook = Textbook.new(title: "Ruby on Rails Tutorial", price: 35.00, subject_id: 1, description: "This is a good read", course_id: 1)
  end

  test "should be valid" do
    assert @textbook.valid?
  end

  test "title should be present" do
    @textbook.title = " "
    assert_not @textbook.valid?
  end

  test "price should be present" do
    @textbook.price = nil
    assert_not @textbook.valid?
  end

  test "title should not be too long" do
    @textbook.title = 'a' * 71
    assert_not @textbook.valid?
  end

  test "price should be a number" do
    @textbook.price = "thirty five dollars"
    assert_not @textbook.valid?
  end

  test "price should be a positive number" do
    @textbook.price = -10
    assert_not @textbook.valid?
  end

  test "price should not be too high" do
    @textbook.price = 1000
    assert_not @textbook.valid?
  end
end
