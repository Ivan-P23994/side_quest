require "sidekiq"

module ContractServices
  class CreateVoucherTypeService < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(description)
      write("createVoucherType", description)
    end

    def call(description)
      write("createVoucherType", description) # returns tx hash as string
    end
  end
end
