# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

jim     = User.create!(name: "Jim")
adam    = User.create!(name: "Adam")
bob     = User.create!(name: "Bob")
charlie = User.create!(name: "Charlie")
dan     = User.create!(name: "Dan")
eli     = User.create!(name: "Eli")

jim.friendships.create!(friend: adam)
jim.friendships.create!(friend: bob)

adam.friendships.create!(friend: bob)
adam.friendships.create!(friend: charlie)

bob.friendships.create!(friend: charlie)
bob.friendships.create!(friend: dan)

charlie.friendships.create!(friend: jim)
charlie.friendships.create!(friend: adam)
charlie.friendships.create!(friend: bob)
charlie.friendships.create!(friend: dan)
charlie.friendships.create!(friend: eli)

dan.friendships.create!(friend: eli)
dan.friendships.create!(friend: charlie)

eli.friendships.create!(friend: dan)
eli.friendships.create!(friend: charlie)
