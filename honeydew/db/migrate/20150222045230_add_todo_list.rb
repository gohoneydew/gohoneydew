class AddTodoList < ActiveRecord::Migration
  def up
    add_column :tasks, :todolist, :text, array: true, default: []
  end

  def down
    remove_column :tasks, :todolist, :text, array: true, default: []
  end
end
