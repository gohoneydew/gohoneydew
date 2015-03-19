# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
JobCategory.create!(:name => "Dog Walking", :user_generated => false)
JobCategory.create!(:name => "Animals", :user_generated => false)
JobCategory.create!(:name => "Indoor - Home", :user_generated => false)
JobCategory.create!(:name => "Outdoor - Home", :user_generated => false)
JobCategory.create!(:name => "Food", :user_generated => false)
JobCategory.create!(:name => "Technical", :user_generated => false)
JobCategory.create!(:name => "Automobile", :user_generated => false)
JobCategory.create!(:name => "Babysitting", :user_generated => false)
JobCategory.create!(:name => "Cleaning", :user_generated => false)

