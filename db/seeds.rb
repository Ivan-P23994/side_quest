require 'faker'
require 'bcrypt'
require 'csv'

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

# Mission Seeding

missions_csv_path = Rails.root.join('db', 'missions.csv')  # adjust path if needed
missions_csv_text = File.read(missions_csv_path)
missions_csv = CSV.parse(missions_csv_text, headers: true)

missions_csv.each do |row|
  puts row.to_h.inspect
  Mission.create!(
    title: row['title'],
    description: row['description'],
    owner_id: users['organization'].id
  )
end



# Quest Seeding

puts "Seeding quests..."

quests_csv_path = Rails.root.join('db', 'quests.csv')  # adjust path if needed
quests_csv_text = File.read(quests_csv_path)
quests_csv = CSV.parse(quests_csv_text, headers: true)

quests_csv.each do |row|
  Quest.create!(title: row['title'], mission_id: row['mission_id'], description: row['description'])
end


puts "Seeding completed!"