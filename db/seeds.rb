require 'faker'
require "open-uri"

unless Rails.env == 'production'
  puts '💥 Destroying DB'

  Painting.destroy_all
  User.destroy_all

  puts '✅ Done'

  puts '💻 Creation of 20 paintings ...'

  20.times do
    file = URI.open('https://res.cloudinary.com/dxcrr7aon/image/upload/v1656261368/db7pmtcemht4ed4zbltn.jpg')
    painting = Painting.create!(
      title: "Peinture de style #{Faker::Artist.name}",
      description: Faker::Lorem.paragraph(sentence_count: 5),
      price: %w[50 80 100 150 170 200 250 310 460].sample,
      sell: %w[true false].sample
    )

    painting.photo.attach(io: file, filename: 'painting_default.jpg', content_type: 'image/jpg')
  end

  puts Painting.count == 20 ? '✅ 20 paintings created' : '⛔ There was a problem'
  puts 'No picture attached' unless Painting.first.photo.attached?

  puts "💻Creation of two users: one admin and one lambda"

  file = URI.open('https://res.cloudinary.com/dxcrr7aon/image/upload/v1655989899/ngpj86fxcbbu4tb0249w.png')
  main_user = User.create(
    first_name: 'Benjamin',
    last_name: 'Liet',
    email: 'benjamin.liet@eligia.fr',
    password: '123456',
    admin: true
  )
  main_user.photo.attach(io: file, filename: 'main_user.png', content_type: 'image/png')

  file = URI.open('https://res.cloudinary.com/dxcrr7aon/image/upload/v1659517750/kmciusgydovfekdvnhxm.png')
  second_user = User.create(
    first_name: 'Monsieur',
    last_name: 'X',
    email: 'mail@mail.fr',
    password: '123456'
  )

  second_user.photo.attach(io: file, filename: 'second_user.png', content_type: 'image/png')

  puts User.count == 2 ? '✅ Users created' : '⛔ There was a problem'
end
