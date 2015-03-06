class AddMessageStatusBackToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :message_status, :string
  end
  def down
    remove_column :messages, :message_status
  end
end
