# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    class Merchant
      attr_reader :uid, :features, :transactions

      extend Methods

      def initialize(opts = {})
        @features = opts
        @uid = @features['uid']
        @transactions = Transaction.new @uid
      end

      def update(opts = {})
        parent = self.class
        parent.assert_one_of!(opts, :notify_url, :return_url, :metadata, :status)
        response = parent.post parent.generate_uri(:merchants, uid), opts
        Merchant.new response
      end

      def delete
        update(status: :terminated)
      end

      def suspend
        update(status: :suspended)
      end

      def migrate(opts = {})
        parent = self.class
        parent.assert_required_keys!(opts, :coc_nr, :country)
        response = parent.post parent.generate_uri(:merchants, uid, :migrate), opts
        Merchant.new response
      end

      def self.create(opts = {})
        assert_required_keys!(opts, :country, :emailaddress, :notify_url, :phone)
        Merchant.new post(generate_uri(:merchants), opts)
      end

      def self.find(uid)
        response = fetch generate_uri(:merchants, uid)
        Merchant.new response
      end
    end

    def self.merchants
      Merchant
    end
  end
end
