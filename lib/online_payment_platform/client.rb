# frozen_string_literal: true

require 'net/https'
require 'json'
require 'online_payment_platform/client/transaction'

module OnlinePaymentPlatform
  class Client
    def self.generate_uri(*path)
      encoded_uri = URI.encode(OnlinePaymentPlatform.configuration.base_uri + path.join('/'))
      URI.parse encoded_uri
    end

    def self.fetch(uri)
      config = OnlinePaymentPlatform.configuration

      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{config.api_key}"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request req
      end

      JSON.parse response.body
    end
  end
end
