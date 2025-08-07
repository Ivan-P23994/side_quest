require "test_helper"

class VoucherTypeTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test "is valid with valid attributes" do
    voucher_type = build(:voucher_type)
    assert voucher_type.valid?
  end

  test "is valid without a voucher" do
    voucher_type = build(:voucher_type, voucher: nil)
    assert voucher_type.valid?
  end

  test "contract can be nil" do
    voucher_type = build(:voucher_type, contract: nil)
    assert voucher_type.valid?
  end

  test "contract can be a string" do
    voucher_type = build(:voucher_type, contract: "Special Contract")
    assert voucher_type.valid?
  end
end
