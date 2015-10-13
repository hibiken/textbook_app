class AddSubjectIdToTextbooks < ActiveRecord::Migration
  def change
    add_reference :textbooks, :subject, index: true, foreign_key: true
  end
end
