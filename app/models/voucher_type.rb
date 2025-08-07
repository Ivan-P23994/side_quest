class VoucherType < ApplicationRecord
  belongs_to :voucher, optional: true
end
