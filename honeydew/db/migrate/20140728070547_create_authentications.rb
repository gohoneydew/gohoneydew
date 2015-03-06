class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.belongs_to :user, index: true
      t.string :provider
      t.string   :uid
      t.string   :oauth_token
      t.string   :oauth_expires_at
      t.timestamps
    end
  end
end
