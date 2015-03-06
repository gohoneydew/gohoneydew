class AddLocalToTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :local, :boolean, :default => :true
  end
  def down
    remove_column :tasks, :local
  end
end
