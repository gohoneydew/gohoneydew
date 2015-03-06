class AddDataToOffers < ActiveRecord::Migration
  def up
    add_column :offers, :sender_id, :integer
    add_column :offers, :recipient_id, :integer
    add_column :offers, :active, :boolean, :default => true
  end
  def down
    remove_column :offers, :sender_id
    remove_column :offers, :recipient_id
  end
end
