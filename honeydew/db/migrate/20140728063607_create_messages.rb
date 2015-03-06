class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :subject
      t.text :body
      t.integer :task_id
      t.integer :proposed_price
      t.integer :wallet_price
      t.string   :message_status
      t.string   :message_type, default: "message"
      t.timestamps
    end
  end
end
