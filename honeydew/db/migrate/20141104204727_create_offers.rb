class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :subject
      t.belongs_to :task, index: true
      t.belongs_to :user, index: true #denoted as sender_id
      t.decimal :proposed_price
      t.string :body
      t.string :status
      t.boolean :unread, :default => true
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
