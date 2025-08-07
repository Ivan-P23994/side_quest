require 'sidekiq'

module ContractServices
  class BurnVoucherService < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(from, id, amount)
      write("burnVoucher", [from, id, amount])
    end
  end
end
