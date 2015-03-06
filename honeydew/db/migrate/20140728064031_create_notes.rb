class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :task, index: true
      t.text :body
      t.integer :sender_id
      t.integer :recipient_id
      t.string   :status, default: "unread"
      t.timestamps
    end
  end
end
