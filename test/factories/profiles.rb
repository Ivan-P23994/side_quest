FactoryBot.define do
  factory :profile do
    user { nil }
    website { "MyString" }
    phone_number { "MyString" }
    country { "MyString" }
    city { "MyString" }
    about_me { "MyString" }
    username { "MyString" }
  end
end
