# frozen_string_literal: true
require 'csv'

exercises = CSV.read(Rails.root.join('db', 'exercises.csv'), headers: true, header_converters: :symbol)
exercises.each_with_index do |row, i|
  puts i
 name = row[:name]
 equipment = row[:equipment]
 focus = row[:focus]
 video = row[:video]
 remote_images = row[:images]
 description = row[:description]
 exercise_type = row[:type]
 GeneralExercise.create!(
  title: name,
  equipment: equipment,
  focus: focus,
  video: video,
  remote_images: remote_images,
  description: description,
  exercise_type: exercise_type
 )
end
# last =
Trainer.create!(
 name: 'Simon',
 email: 'simon_somlai@hotmail.com',
 password: 'password',
 password_confirmation: 'password',
 image: Rails.root.join('app/assets/images/me.jpg').open,
 admin: true
)

# Trainer.create!(
#  name: 'Tom',
#  email: 'tom@hotmail.com',
#  password: 'password',
#  password_confirmation: 'password',
#  image: Rails.root.join('app/assets/images/you.jpg').open,
#  admin: false
# )
#
# count = 1
# 2.times do
#  name = Faker::Name.name
#  email = Faker::Internet.email
#  phone = Faker::PhoneNumber.cell_phone
#  description = Faker::Lorem.paragraph(5)
#  adres = Faker::Address.street_address
#  Client.create!(
#   name: name,
#   email: email,
#   password: 'password',
#   password_confirmation: 'password',
#   address: adres,
#   phone: phone,
#   information: description,
#   image: Rails.root.join('app/assets/images/client' + count.to_s + '.jpg').open,
#   trainer_id: 1,
#   admin: false
#  )
#  count += 1
# end
#
# 5.times do
#  name = Faker::Book.title
#  description = Faker::Lorem.paragraph(5)
#  video = Faker::Internet.url('example.com')
#  CustomExercise.create!(
#   title: 'Simon ' + name,
#   description: description,
#   focus: "Myfocus",
#   exercise_type: "Krachttraining",
#   video: video,
#   trainer_id: 1
#  )
# end
#
# 5.times do
#  name = Faker::Book.title
#  description = Faker::Lorem.paragraph(5)
#  video = Faker::Internet.url('example.com')
#  CustomExercise.create!(
#   title: 'Tom ' + name,
#   description: description,
#   video: video,
#   exercise_type: "Krachttraining",
#   focus: "Myfocus",
#   trainer_id: 2
#  )
# end
#
# 5.times do
#  name = Faker::Book.title
#  description = Faker::Lorem.paragraph(5)
#  Training.create!(
#   title: name,
#   description: description,
#   time: '1 uur',
#   level: (1..5).to_a.sample,
#   trainer_id: (1..2).to_a.sample
#  )
# end
#
# Training.all.each do |training|
#  6.times do
#   AssignedTraining.create!(
#    exercise_id: (1..250).to_a.sample,
#    training_id: training.id
#   )
#  end
# end
#
# Client.all.each do |client|
#  2.times do
#     name = Faker::Book.title
#    id =  (1..5).to_a.sample
#   ClientTraining.create!(
#    training_id: id,
#    title: name,
#    client_id: client.id
#   )
#  end
# end
