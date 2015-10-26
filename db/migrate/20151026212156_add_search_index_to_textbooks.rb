class AddSearchIndexToTextbooks < ActiveRecord::Migration
  def up
    execute "CREATE INDEX textbooks_title ON textbooks USING gin(to_tsvector('english', title))"
    execute "CREATE INDEX textbooks_description ON textbooks USING gin(to_tsvector('english', description))"
  end

  def down
    execute "DROP INDEX textbooks_title"
    execute "DROP INDEX textbooks_description"
  end
end
