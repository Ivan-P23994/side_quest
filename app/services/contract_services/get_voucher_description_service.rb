require 'sidekiq'

module ContractServices
  class GetVoucherDescriptionService < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(id)
      read("getVoucherDescription", [id])
    end
  end
end
