class CreateJobCategories < ActiveRecord::Migration
  def change
    create_table :job_categories do |t|
      t.string :name
      t.references :tasks , index: true
      t.boolean :user_generated

      t.timestamps
    end
  end
end
