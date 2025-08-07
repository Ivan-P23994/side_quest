require 'test_helper'

class ConfirmOwnerTest < ActiveSupport::TestCase
  def setup
    Sidekiq::Worker.clear_all
    @service = ContractServices::ConfirmOwner.new
  end

  test "enqueues the job" do
    assert_equal 0, ContractServices::ConfirmOwner.jobs.size
    ContractServices::ConfirmOwner.perform_async("0xF03614C73A6e50Aa07B737AB73d0dceb32556F28")
    assert_equal 1, ContractServices::ConfirmOwner.jobs.size
  end

  test "returns true when the address is the owner" do
    @service.stubs(:read).with("owner").returns("0xF03614C73A6e50Aa07B737AB73d0dceb32556F28")
    assert @service.perform("0xF03614C73A6e50Aa07B737AB73d0dceb32556F28")
  end

  test "returns false when the address is not the owner" do
    @service.stubs(:read).with("owner").returns("0xSomeOtherAddress")
    refute @service.perform("0xF03614C73A6e50Aa07B737AB73d0dceb32556F28")
  end
end
