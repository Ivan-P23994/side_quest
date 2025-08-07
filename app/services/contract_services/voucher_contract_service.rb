require "eth"
require "dotenv/load"
require "json"

class ContractServices::VoucherContractService
  def initialize
    @eth_client = Eth::Client.create(ENV.fetch("SEPOLIA_RPC_URL"))
    @contract = Eth::Contract.from_abi(
      name: "Voucher1155",
      address: ENV.fetch("VOUCHER_CONTRACT_ADDRESS"),
      abi: JSON.parse(File.read(Rails.root.join("config", "abi", "side_quest_voucher_abi.json")))
    )
    @key = Eth::Key.new(priv: ENV.fetch("PRIVATE_KEY"))
  end

  # Read-only contract call (eth_call)
  def read(function, *args)
    @eth_client.call(@contract, function, *args)
  end

  # State-changing contract transaction (eth_sendRawTransaction)
  def write(function, *args, value: 0)
    @eth_client.transact(
      @contract,
      function,
      *args,
      sender_key: @key,
      gas_limit: 300_000,
      tx_value: value
    )
  end
end
