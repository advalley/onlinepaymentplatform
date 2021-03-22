module OnlinePaymentPlatform
  class Client
    def self.status
      fetch URI.parse('https://api-sandbox.onlinebetaalplatform.nl/status')
    end
  end
end
