30.times do
  User.create(first_name:Faker::Name.first_name, last_name:Faker::Name.last_name, email: Faker::Internet.email, password: 'password', artist:true)
end

Colorcard.create(name:"red")
Colorcard.create(name:"orange")
Colorcard.create(name:"yellow")
Colorcard.create(name:"green")
Colorcard.create(name:"blue")
Colorcard.create(name:"purple")
Colorcard.create(name:"black")
Colorcard.create(name:"white")
