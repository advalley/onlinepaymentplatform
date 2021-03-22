module OnlinePaymentPlatform
  class Client
    class Transaction
      def self.create(_opts = {})
        assert_present_keys!(_opts,  :merchant_id, :total_price, :products)
      end


      def self.assert_present_keys!(options, *keys)
        keys.each do |key|
          raise 'Required key missing!' if options.dig(key).nil?
        end
      end
    end
  end
end
