class Review < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :score, presence: :true, inclusion: {:in => 0..5}
  validates :body, presence: :true, length: {maximum:140}
end
