FactoryBot.define do
  factory :voucher do
    association :voucher_type
    association :owner, factory: :user
    transaction_hash { "0xabc" }
    redeemed { false }
    title { "Sample Voucher" }
    description { "This is a sample voucher description." }
  end
end
