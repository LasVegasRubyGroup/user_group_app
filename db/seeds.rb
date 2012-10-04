# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Topic.destroy_all
Volunteer.destroy_all

User.create!(
  name: 'User Bob',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  organizer: false
)

User.create!(
  name: 'User Smith',
  email: 'organizer@example.com',
  password: 'password',
  password_confirmation: 'password',
  organizer: true
)

topic = Topic.create!(
  title: 'How to use Parenthesis',
  description: 'Just use them!'
)

topic.volunteers.create!(
  user_id: User.first._id
)