FactoryBot.define do
  factory :omni_auth_identity do
    uid { "MyString" }
    provider { "MyString" }
    user { nil }
  end
end
