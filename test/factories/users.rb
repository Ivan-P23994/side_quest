FactoryBot.define do
  factory :user do
    # Use sequence to guarantee unique emails for tests
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password    { "password123" }
    user_type   { "volunteer" }  # or "business"/"organization" as needed
  end
end
