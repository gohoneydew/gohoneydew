class Note < ActiveRecord::Base
  belongs_to :task
  validates_presence_of :body
end
