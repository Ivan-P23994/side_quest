require 'faker'
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

require 'faker'

20.times do |i|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "#{first_name.downcase}.#{last_name.downcase}#{i+1}@example.com"

  User.create!(
    email_address: email,
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD,
    user_type: "volunteer",
    active: true
  )
  puts "Created volunteer user with email: #{email}"
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


# Grab all volunteer users (assuming 'volunteer' as user_type)
volunteers = User.where(user_type: 'volunteer').to_a

puts "Seeding applications..."

Quest.all.each do |quest|
  # Pick 10 random, unique volunteers for each quest
  applicants = volunteers.sample(10)

  applicants.each do |volunteer|
    # Find the mission owner as approver
    approver_id = quest.mission.owner_id

    Application.create!(
      quest_id: quest.id,
      applicant_id: volunteer.id,
      approver_id: approver_id,
      status: "pending"
    )
    puts "Created application for quest #{quest.id} by volunteer #{volunteer.email_address}"
  end
end

volunteer_user = users['volunteer']
sample_quests = Quest.limit(10)

sample_quests.each do |quest|
  # Create a UserQuest record
  UserQuest.create!(
    user: volunteer_user,
    quest: quest
  )

  # Create an Application record (if one doesn't already exist)
  Application.create!(
    quest: quest,
    applicant: volunteer_user,
    approver: quest.mission.owner,
    status: "approved"
  )
end



puts "Seeding completed!"