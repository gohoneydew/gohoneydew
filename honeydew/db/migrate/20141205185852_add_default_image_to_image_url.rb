class AddDefaultImageToImageUrl < ActiveRecord::Migration
  def change
    change_column_default :users, :image_url, "avatar.jpg"
  end
end
