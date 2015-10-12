class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.string :title
      t.decimal :price, precision: 6, scale: 2
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
