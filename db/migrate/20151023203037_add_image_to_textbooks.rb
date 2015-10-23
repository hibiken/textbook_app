class AddImageToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :image, :string
  end
end
