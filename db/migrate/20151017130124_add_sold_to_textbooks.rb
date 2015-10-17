class AddSoldToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :sold, :boolean, default: false
  end
end
