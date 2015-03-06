class ChangeUnreadAttributeMessages < ActiveRecord::Migration
  def up
    add_column :messages, :unread, :boolean, :default => true
  end

  def down
    remove_column :messages, :unread, :boolean
  end
end
