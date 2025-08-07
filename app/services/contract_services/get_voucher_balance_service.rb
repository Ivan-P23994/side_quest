require "sidekiq"

module ContractServices
  class GetVoucherBalanceService < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(account, id)
      read("balanceOf", [ account, id ])
    end
  end
end
