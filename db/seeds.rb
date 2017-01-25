User.create!(name:  "Richard",
             email: "richardh@iinet.net.au",
             password:              "password",
             password_confirmation: "password",
             privileges: "admin",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               privileges: "user",
               activated: true,
               activated_at: Time.zone.now)
end
