require "sidekiq"

module ContractServices
  class CreateVoucherTypeService < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(description)
      write("createVoucherType", [ description ])
    end
  end
end
