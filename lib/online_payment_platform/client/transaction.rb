# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    class Transaction
      extend Methods

      def self.create(opts = {})
        assert_required_keys!(opts, :merchant_id, :total_price, :products)
      end
    end

    def self.transactions
      Transaction
    end
  end
end
