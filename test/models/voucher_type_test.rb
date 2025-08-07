require "test_helper"

class VoucherTypeTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test "is valid with valid attributes" do
    voucher_type = build(:voucher_type)
    assert voucher_type.valid?
  end

  test "can have zero vouchers" do
    voucher_type = build(:voucher_type)
    assert_equal 0, voucher_type.vouchers.size
  end

  test "can have multiple vouchers" do
    voucher_type = create(:voucher_type)
    create_list(:voucher, 3, voucher_type: voucher_type)
    assert_equal 3, voucher_type.vouchers.count
  end

  test "has correct title" do
    voucher_type = build(:voucher_type, title: "Holiday Special")
    assert_equal "Holiday Special", voucher_type.title
  end

  test "can have a description" do
    voucher_type = build(:voucher_type, description: "Super saver voucher")
    assert_equal "Super saver voucher", voucher_type.description
  end

  test "persisted voucher_type retains attributes" do
    voucher_type = create(:voucher_type, title: "Promo", description: "Limited edition")
    found = VoucherType.find(voucher_type.id)
    assert_equal "Promo", found.title
    assert_equal "Limited edition", found.description
  end
end
