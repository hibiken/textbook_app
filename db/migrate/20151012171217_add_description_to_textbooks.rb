class AddDescriptionToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :description, :text
  end
end
