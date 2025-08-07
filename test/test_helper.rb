ENV["RAILS_ENV"] ||= "test"
ENV["SEPOLIA_RPC_URL"] ||= "http://localhost:8545"
ENV["VOUCHER_CONTRACT_ADDRESS"] ||= "0x0000000000000000000000000000000000000000"
ENV["PRIVATE_KEY"] ||= "0x" + "1" * 64
ENV["SIDE_QUEST_VOUCHER_ABI"] ||= {"dummy": "abi"}.to_json

require_relative "../config/environment"
require "rails/test_help"
require 'mocha/minitest'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
