# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = []
user_data = [
  {first_name: "Diego", last_name: "Fernandez", email: "difernandez@uc.cl", password: "blabla", password_confirmation: "blabla"},
  {first_name: "Fernando", last_name: "Lizana", email: "flizana1@uc.cl", password: "blabla", password_confirmation: "blabla"}
]

user_data.each do |u|
  users.push(User.create(u))
end

raffles = []
raffle_data = [
  {name: "Rifa Scout", prize: "TV", price: "1000", finish_date: DateTime.current(), user_id: User.first.id},
  {name: "Rifa DCC", prize: "Notebook", price: "1000", finish_date: DateTime.current(), user_id: User.first.id},
  {name: "Rifa Pastoral", prize: "Microondas", price: "1000", finish_date: DateTime.current(), user_id: User.last.id},
  {name: "Rifa TDI", prize: "Radio", price: "1000", finish_date: DateTime.current(), user_id: User.last.id}
]

raffle_data.each do |r|
  raffles.push(Raffle.create(r))
end

participate_data = [
  {user_id: users.last.id, raffle_id: raffles.first.id},
  {user_id: users.first.id, raffle_id: raffles.last.id}
]

participate_data.each do |p|
  Participate.create(p)
end

bookmark_data = [
  {user_id: users.first.id, raffle_id: raffles[2].id},
  {user_id: users.last.id, raffle_id: raffles[1].id}
]

bookmark_data.each do |b|
  Bookmark.create(b)
end