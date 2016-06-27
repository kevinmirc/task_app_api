# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
  User.create(id: i, email: Faker::Internet.email, password: 'password123')
end

(1..10).each do |i|
  rand((4..15)).times do
    Task.create(title: Faker::Name.title, description: Faker::Lorem.paragraph, author_id: i)
  end
end