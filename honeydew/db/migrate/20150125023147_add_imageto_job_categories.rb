class AddImagetoJobCategories < ActiveRecord::Migration
  def up
    add_column :job_categories, :image_url, :text
  end
  def down
    remove_column :job_categories, :image_url
  end
end
