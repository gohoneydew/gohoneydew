class JobCategory < ActiveRecord::Base
  has_many :tasks

  scope :alphabetized, -> {order("name ASC")}
end
