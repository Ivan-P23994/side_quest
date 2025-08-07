class CreateVouchers < ActiveRecord::Migration[8.0]
  def up
    create_table :vouchers do |t|
      t.references :voucher_type, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :transaction_hash
      t.boolean :redeemed
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :vouchers
  end
end
