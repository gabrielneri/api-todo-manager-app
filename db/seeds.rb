# db/seeds.rb
require 'faker'

Faker::Config.locale = 'pt-BR'

# Criando 6 users
6.times do |i|
  name = Faker::Name.unique.first_name
  email = Faker::Internet.unique.email(name: name)
  password = 'password12345'
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
  # Criando as tasks p/ cada User
  12.times do |j|
    title = Faker::Lorem.sentence(word_count: 2)
    description = Faker::Lorem.paragraph
    status = j.even? ? 'finished' : 'not_finished'
    visibility = 'public_task'
    Task.create!(
      title: title,
      description: description,
      status: status,
      visibility: visibility,
      user: user
    )
  end
end
