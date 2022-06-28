require 'faker'

puts 'Destroying DB'

Painting.destroy_all

puts 'Done'

puts 'Now, let add 20 paintings ...'

20.times do
  file = URI.open('https://res.cloudinary.com/dxcrr7aon/image/upload/v1656261368/db7pmtcemht4ed4zbltn.jpg')
  painting = Painting.create!(
    title: Faker::Movies::StarWars.quote,
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  painting.photo.attach(io: file, filename: 'painting_default.jpg', content_type: 'image/jpg')
end

puts 'Here we go'
