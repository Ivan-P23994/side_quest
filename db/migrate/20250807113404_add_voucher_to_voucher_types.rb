class AddVoucherToVoucherTypes < ActiveRecord::Migration[8.0]
  def change
    add_reference :voucher_types, :voucher, null: true, foreign_key: true
  end
end
