class AddSlugToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :slug, :string
    add_index :textbooks, :slug, unique: true
  end
end
