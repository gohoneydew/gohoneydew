class AddDefaultImageToImageUrl2 < ActiveRecord::Migration
  def change
    change_column_default :users, :image_url, "/assets/avatar.jpg"
  end
end
