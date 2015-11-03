class AddSubjectIdToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :subject, index: true, foreign_key: true
  end
end
