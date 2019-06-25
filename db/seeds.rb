# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.destroy_all
Liking.destroy_all
Follow.destroy_all
User.destroy_all
Entry.destroy_all
Message.destroy_all

user1 = User.create(first_name: "Lorenzo", last_name: "Llamas", username: "SeptemberLlamas", password: "x", bio: "Hi I am Lorenzo", age: 23)
user2 = User.create(first_name: "Tony", last_name: "Stark", username: "IAmIronMan", password: "x", bio: "Hey I am Tony", age: 55)
user3 = User.create(first_name: "Steve", last_name: "Rogers", username: "Cap", password: "x", bio: "Merica", age: 175)

entry1_lorenzo = Entry.create(title: "My first post!", category: "Social", content: "Glad to have created my first post!", user_id: user1.id)
entry2_tony = Entry.create(title: "Thanos Sucks!", category: "Social", content: "I am Iron Man", user_id: user2.id)

comment_on_entry_one = Comment.create(content: "commenting on my own post!", user_id: user1.id, entry_id: entry1_lorenzo.id)

liking_on_entry_two = Liking.create(user_id: user2.id, entry_id: entry2_tony.id)
liking_on_entry_two_lorenzo = Liking.create(user_id: user2.id, entry_id: entry1_lorenzo.id)

steve_follows_lorenzo = Follow.create(follower_id: user3.id, followee_id: user1.id)
tony_follows_lorenzo = Follow.create(follower_id: user2.id, followee_id: user1.id)


lorenzo_to_steve = Message.create(content: "I'm the real Captain America ...", sender_id: user1.id, receiver_id: user3.id)
steve_to_lorenzo = Message.create(content: "Hail Hydra ...", sender_id: user3.id, receiver_id:user1.id)
