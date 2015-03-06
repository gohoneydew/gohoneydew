class RemoveDefaultFromRatingsRequired < ActiveRecord::Migration
  def change
    change_column_default(:tasks, :rating_required, nil)
    change_column_default(:tasks, :no_ratings_required, nil)
  end
end
