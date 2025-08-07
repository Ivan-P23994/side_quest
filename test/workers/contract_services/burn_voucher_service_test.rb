require 'test_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!
require_relative '../../../app/services/contract_services/burn_voucher_service'

class ContractServices::BurnVoucherServiceTest < ActiveSupport::TestCase
  setup do
    @worker = ContractServices::BurnVoucherService.new
    @from = "0x1234567890abcdef1234567890abcdef12345678"
    @id = 42
    @amount = 3
    ContractServices::BurnVoucherService.jobs.clear
  end

  test "enqueues the job" do
    assert_difference 'ContractServices::BurnVoucherService.jobs.size', 1 do
      ContractServices::BurnVoucherService.perform_async(@from, @id, @amount)
    end
  end

  test "calls write with correct arguments" do
    called = false
    function_arg = nil
    args_arg = nil

    # Monkeypatch instance method for this instance only
    def @worker.write(function, args)
      @test_write_called = true
      @test_function_arg = function
      @test_args_arg = args
      "tx_hash_burn"
    end

    result = @worker.perform(@from, @id, @amount)

    assert_equal true, @worker.instance_variable_get(:@test_write_called)
    assert_equal "burnVoucher", @worker.instance_variable_get(:@test_function_arg)
    assert_equal [@from, @id, @amount], @worker.instance_variable_get(:@test_args_arg)
    assert_equal "tx_hash_burn", result
  end

  test "sidekiq retry is disabled" do
    assert_equal false, ContractServices::BurnVoucherService.sidekiq_options_hash["retry"]
  end
end
