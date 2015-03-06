class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :task, index: true
      t.belongs_to :user, index: true
      t.text :body
      t.integer :score
      t.integer :poster_id
      t.timestamps
    end
  end
end
