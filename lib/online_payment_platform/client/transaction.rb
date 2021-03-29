# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    class Transaction
      include Methods

      attr_reader :merchant_uid, :uid
      attr_accessor :features

      def initialize(merchant_uid, uid = nil)
        @merchant_uid = merchant_uid
        @uid = uid
      end

      def create(opts = {})
        assert_required_keys!(opts, :total_price, :products)
        post generate_uri(:transactions), set_params(opts)
      end

      def find(uid)
        response = fetch generate_uri(:transactions, uid)
        object = Transaction.new merchant_uid, uid
        object.features = response

        return object
      end

      def refund!(opts = {})
        assert_required_keys!(opts, :amount)
        post generate_uri(:transactions, uid, :refunds), opts
      end

      def refunds
        fetch generate_uri(:transactions, uid, :refunds)
      end

      private

      def set_params(opts)
        opts.merge! merchant_uid: merchant_uid
      end
    end
  end
end
