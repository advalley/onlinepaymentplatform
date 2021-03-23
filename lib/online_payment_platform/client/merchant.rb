module OnlinePaymentPlatform
  class Client
    class Merchants
      attr_reader :uid, :features

      extend Methods

      def initialize(opts = {})
        @features = opts
        @uid = @features['uid']
      end

      def update(_opts = {})
        parent = self.class
        parent.assert_one_of!(_opts, :notify_url, :return_url, :metadata)
        parent.post parent.generate_uri('merchants', uid), _opts
      end

      def migrate(_opts = {})
        parent = self.class
        parent.assert_required_keys!(_opts, :coc_nr, :country)
        response = parent.post parent.generate_uri('merchants', uid, 'migrate'), _opts
        Merchants.new response
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
