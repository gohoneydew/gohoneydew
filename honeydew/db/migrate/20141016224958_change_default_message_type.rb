class ChangeDefaultMessageType < ActiveRecord::Migration
  def change
    change_column_default(:messages, :message_type, nil)
  end
end
