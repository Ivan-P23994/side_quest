FactoryBot.define do
  factory :voucher_type do
    transaction_hash { "0x123" }
    title { "Sample Voucher Type" }
    description { "This is a sample voucher type description." }
  end
end
