# Seed database with users and user microposts

User.create!(name:  "Richard",
            email: "richardh@iinet.net.au",
             password:              "Palumpa22",
             password_confirmation: "Palumpa22",
             privileges: "admin",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)


30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password-#{n+1}"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               privileges: "user",
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
