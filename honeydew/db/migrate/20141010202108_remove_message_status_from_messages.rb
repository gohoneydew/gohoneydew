class RemoveMessageStatusFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :message_status
  end
  def down
    add_column :messages, :message_status, :string
  end
end
