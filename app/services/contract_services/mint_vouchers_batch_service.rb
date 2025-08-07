# frozen_string_literal: true

require "sidekiq"

module ContractServices
  class MintVouchersBatchService < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(to, ids, amounts)
      write("mintVouchersBatch", [ to, ids, amounts, "0x" ])
    end

    def call(ids, amounts, to: ENV.fetch("OWNER_ADDRESS"))
      write("mintVouchersBatch",  to, ids, amounts, "0x")
    end
  end
end
