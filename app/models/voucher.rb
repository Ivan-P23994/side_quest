class Voucher < ApplicationRecord
  belongs_to :voucher_type
  belongs_to :owner, class_name: "User"
end
