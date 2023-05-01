  name = '管理者'
  email = 
  password = 
  admin = true
  User.create!(name: name,
               email: email,
               password: password,
               admin: admin
               )

9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  admin = false
  User.create!(name: name,
               email: email,
               password: password,
               admin: admin
               )
end

10.times do |n|
  title = Faker::Games::Pokemon.location
  content = Faker::Games::Pokemon.name
  status = "完了"
  priority = 1
  expired_at = 3.day.from_now
  Task.create!(title: title,
               content: content,
               status: status,
               priority: priority,
               expired_at: expired_at,
               user_id: 2
               )
end

10.times do |n|
  lbl_name = Faker::Games::Pokemon.move
  Label.create!(lbl_name: lbl_name)
end