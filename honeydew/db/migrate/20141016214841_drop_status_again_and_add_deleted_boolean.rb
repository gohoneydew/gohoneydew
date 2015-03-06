class DropStatusAgainAndAddDeletedBoolean < ActiveRecord::Migration
  def up
    remove_column :messages, :message_status, :string
    add_column :messages, :deleted, :boolean, :default => false
  end
  def down
    add_column :messages, :message_status
    remove_column :messages, :deleted, :boolean, :default => false
  end
end
