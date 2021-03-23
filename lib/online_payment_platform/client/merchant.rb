module OnlinePaymentPlatform
  class Client
    class Merchants
      attr_reader :uid

      extend Methods

      def initialize(opts = {})
        @uid = opts['uid']
      end

      def update(_opts = {})
        parent = self.class
        parent.assert_one_of!(_opts, :notify_url, :return_url, :metadata)
        parent.post parent.generate_uri('merchants', uid), _opts
      end

      def self.create(_opts = {})
        assert_required_keys!(_opts, :country, :emailaddress, :notify_url, :phone)
        Merchants.new post(generate_uri('merchants'), _opts)
      end

      def self.find(uid)
        response = fetch generate_uri('merchants', uid)
        Merchants.new response
      end

    end

    def self.merchants
      Merchants
    end
  end
end
