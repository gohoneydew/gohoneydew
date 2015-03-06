class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.timestamps
      t.datetime :task_date
      t.text     :subject
      t.text     :description
      t.text     :deliverables
      t.datetime :duration
      t.decimal  :price, precision: 10, scale: 0
      t.datetime :due_date
      t.integer  :zipcode
      t.integer  :rating_required, default: 0
      t.integer  :no_ratings_required, default: 0
      t.integer  :final_rating
      t.string   :final_review
      t.string   :status, default: "open"
      t.string   :task_type, default: "bid"
      t.integer  :wallet_id
      t.integer  :runner_id
      t.string   :task_category
      t.integer  :views
    end
  end
end
