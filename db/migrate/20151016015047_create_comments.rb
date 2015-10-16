class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.references :user, index: true, foreign_key: true
      t.references :textbook, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
