FactoryBot.define do
  factory :mission do
    title { "MyString" }
    body { "MyText" }
    owner { nil }
    quest { nil }
    quest_reward { nil }
  end
end
