class GetVoucherDescriptionServiceTest < ActiveSupport::TestCase
  setup do
    @id = 7
    @worker = ContractServices::GetVoucherDescriptionService.new
    ContractServices::GetVoucherDescriptionService.clear
  end

  test "enqueues the job" do
    assert_difference 'ContractServices::GetVoucherDescriptionService.jobs.size', 1 do
      ContractServices::GetVoucherDescriptionService.perform_async(@id)
    end
  end

  test "calls read with correct arguments" do
    @worker.expects(:read).with("getVoucherDescription", [@id]).returns("Voucher description here")
    assert_equal "Voucher description here", @worker.perform(@id)
  end

  test "sidekiq retry is disabled" do
    assert_equal false, ContractServices::GetVoucherDescriptionService.sidekiq_options_hash["retry"]
  end
end
