class CreateVoucherTypes < ActiveRecord::Migration[8.0]
  def up
    create_table :voucher_types do |t|
      t.string :contract_address

      t.timestamps
    end
  end

  def down
    drop_table :voucher_types
  end
end
