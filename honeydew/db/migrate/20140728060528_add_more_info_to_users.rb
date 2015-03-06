class AddMoreInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :decimal, precision: 10, scale: 0
    add_column :users, :about_me, :text
  end
end
