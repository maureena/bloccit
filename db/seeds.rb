require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

# Create Posts
50.times do
  Post.create(
    user:   users.sample, 
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end
posts = Post.all

# Create Comments
100.times do
  Comment.create(
    # user: users.sample # Haven't associated Users with Comments yet
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

User.first.update_attributes(
  email:    'maureen.adamo@gmail.com',
  password: 'helloworld',
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"