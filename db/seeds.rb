require 'faker'

puts '💥 Destroying DB'

Painting.destroy_all
User.destroy_all

puts '✅ Done'

puts '💻 Creation of 20 paintings ...'

20.times do
  file = URI.open('https://res.cloudinary.com/dxcrr7aon/image/upload/v1656261368/db7pmtcemht4ed4zbltn.jpg')
  painting = Painting.create!(
    title: Faker::Movies::StarWars.quote,
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  painting.photo.attach(io: file, filename: 'painting_default.jpg', content_type: 'image/jpg')
end

puts Painting.count == 20 ? '✅ 20 paintings created' : '⛔ There was a problem'
puts 'No picture attached' unless Painting.first.photo.attached?

puts "💻Creation of two users: one admin and one lambda"

User.create(first_name: 'Benjamin', last_name: 'Liet', email: 'benjamin.liet@eligia.fr', password: '123456', admin: true)
User.create(first_name: 'Monsieur', last_name: 'X', email: 'mail@mail.fr', password: '123456')

puts User.count == 2 ? '✅ Users created' : '⛔ There was a problem'
