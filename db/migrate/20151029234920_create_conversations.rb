class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :buyer_id
      t.integer :seller_id

      t.timestamps null: false
    end
    add_index :conversations, :buyer_id
    add_index :conversations, :seller_id
  end
end
