require "test_helper"

class VoucherTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test "is valid with valid attributes" do
    voucher = build(:voucher)
    assert voucher.valid?
  end

  test "is invalid without owner" do
    voucher = build(:voucher, owner: nil)
    assert_not voucher.valid?
    assert_includes voucher.errors[:owner], "must exist"
  end

  test "is invalid without voucher_type" do
    voucher = build(:voucher, voucher_type: nil)
    assert_not voucher.valid?
    assert_includes voucher.errors[:voucher_type], "must exist"
  end

  test "contract_address can be nil" do
    voucher = build(:voucher, contract_address: nil)
    assert voucher.valid?
  end

  test "redeemed can be true" do
    voucher = build(:voucher, redeemed: true)
    assert voucher.valid?
  end
end
