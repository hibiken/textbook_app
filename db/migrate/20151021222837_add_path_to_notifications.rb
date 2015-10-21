class AddPathToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :path, :string
  end
end
