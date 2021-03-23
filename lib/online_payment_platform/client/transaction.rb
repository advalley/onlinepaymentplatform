# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    def self.create_transaction(_opts = {})
      assert_required_keys!(_opts, :merchant_id, :total_price, :products)
    end
  end
end
