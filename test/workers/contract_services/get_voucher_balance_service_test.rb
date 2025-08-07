class GetVoucherBalanceServiceTest < ActiveSupport::TestCase
  setup do
    @account = "0x1234567890123456789012345678901234567890"
    @id = 42
    @worker = ContractServices::GetVoucherBalanceService.new
    ContractServices::GetVoucherBalanceService.clear
  end

  test "enqueues the job" do
    assert_difference "ContractServices::GetVoucherBalanceService.jobs.size", 1 do
      ContractServices::GetVoucherBalanceService.perform_async(@account, @id)
    end
  end

  test "calls read with correct arguments" do
    @worker.expects(:read).with("balanceOf", [ @account, @id ]).returns(5)
    assert_equal 5, @worker.perform(@account, @id)
  end

  test "sidekiq retry is disabled" do
    assert_equal false, ContractServices::GetVoucherBalanceService.sidekiq_options_hash["retry"]
  end
end
