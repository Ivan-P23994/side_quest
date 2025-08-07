FactoryBot.define do
  factory :voucher do
    association :voucher_type
    association :owner, factory: :user
    contract_address { "0xabc" }
    redeemed { false }
  end
end
