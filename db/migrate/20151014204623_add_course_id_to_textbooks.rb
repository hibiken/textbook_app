class AddCourseIdToTextbooks < ActiveRecord::Migration
  def change
    add_reference :textbooks, :course, index: true, foreign_key: true
  end
end
