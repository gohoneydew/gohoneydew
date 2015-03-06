class CreateTodoitems < ActiveRecord::Migration
  def change
    create_table :todoitems do |t|
      t.text :body
      t.boolean :completed, :default => false
      t.belongs_to :task, index: true

      t.timestamps
    end
  end
end
