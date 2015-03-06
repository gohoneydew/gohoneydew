class AddJobCategoryIDtoTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :job_category_id, :integer, index: true
  end
end
