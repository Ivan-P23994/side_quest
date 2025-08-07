require 'sidekiq'

module ContractServices
  class ConfirmOwner < VoucherContractService
    include Sidekiq::Worker
    sidekiq_options retry: false

    # Checks if the given address is the owner of the contract.
    # Since Sidekiq jobs are async, the return value is not available to the caller.
    def perform(address)
      owner_address = read("owner")
      is_owner = owner_address.downcase == address.downcase
      # You could persist `is_owner` result or notify elsewhere if needed
      is_owner
    end
  end
end
