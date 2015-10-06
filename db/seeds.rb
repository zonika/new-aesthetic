10.times do
  User.create(first_name:Faker::Name.first_name, last_name:Faker::Name.last_name, email: Faker::Internet.email, password: 'password', artist:true)
end

Color.create(name:"red")
Color.create(name:"orange")
Color.create(name:"yellow")
Color.create(name:"green")
Color.create(name:"blue")
Color.create(name:"purple")
Color.create(name:"pink")
