# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    class Transaction
      extend Methods

      def self.create(_opts = {})
        assert_required_keys!(_opts, :merchant_id, :total_price, :products)
      end
    end

    def self.transactions
      Transaction
    end
  end
end
