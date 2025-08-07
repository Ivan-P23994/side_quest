require 'test_helper'

class MintVouchersBatchServiceTest < ActiveSupport::TestCase
  setup do
    @service = ContractServices::MintVouchersBatchService.new
    @to = "0xDEADBEEF00000000000000000000000000000000"
    @ids = [1, 2, 3]
    @amounts = [10, 20, 30]
  end

  test "calls write with correct arguments" do
    called = nil
    expected_args = [@to, @ids, @amounts, "0x"]
    @service.define_singleton_method(:write) do |function, args|
      called = (function == "mintVouchersBatch" && args == expected_args)
      "tx_hash_abc"
    end

    result = @service.perform(@to, @ids, @amounts)
    assert_equal "tx_hash_abc", result
    assert_equal true, called, "Expected write to be called with correct arguments"
  end
end
