# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    class Transaction
      include Methods

      attr_reader :merchant_uid

      def initialize(merchant_uid)
        @merchant_uid = merchant_uid
      end

      def create(opts = {})
        assert_required_keys!(opts, :total_price, :products)
        post generate_uri('transactions'), set_params(opts)
      end

      private

      def set_params(opts)
        opts.merge! merchant_uid: merchant_uid
      end
    end
  end
end
