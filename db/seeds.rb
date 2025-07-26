require 'faker'
require 'bcrypt'

puts "Seeding users..."

DEFAULT_PASSWORD = "password"

user_types = %w[business volunteer organization]
users = {}

user_types.each do |user_type|
  email = "#{user_type}_user@example.com"

  user = User.create!(
    email_address: email,
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD,
    user_type: user_type,
    active: true
  )

  users[user_type] = user
  puts "Created #{user_type} user with email: #{email}"
end

puts "Seeding missions..."

organization_user = users["organization"]

5.times do
  Mission.create!(
    title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 2)[0..54],
    body: Faker::Lorem.paragraph(sentence_count: 4),
    owner_id: organization_user.id
  )
end

puts "Created 5 missions for organization user: #{organization_user.email_address}"
puts "Seeding completed!"
