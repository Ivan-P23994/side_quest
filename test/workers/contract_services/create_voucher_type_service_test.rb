require "test_helper"


class ContractServices::CreateVoucherTypeServiceTest < ActiveSupport::TestCase
  setup do
    @description = "Test voucher"
    @worker = ContractServices::CreateVoucherTypeService.new
    ContractServices::CreateVoucherTypeService.jobs.clear
  end

  test "enqueues the job" do
    assert_difference "ContractServices::CreateVoucherTypeService.jobs.size", 1 do
      ContractServices::CreateVoucherTypeService.perform_async(@description)
    end
  end

  test "calls write with correct arguments" do
    called = nil
    expected_description = @description
    @worker.define_singleton_method(:write) do |function, args|
      called = (function == "createVoucherType" && args ==  expected_description)
      "0xABC123"
    end

    result = @worker.perform(@description)
    assert_equal "0xABC123", result
    assert_equal true, called, "Expected write to be called with correct arguments"
  end

  test "sidekiq retry is disabled" do
    assert_equal false, ContractServices::CreateVoucherTypeService.sidekiq_options_hash["retry"]
  end
end
