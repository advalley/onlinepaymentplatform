# frozen_string_literal: true

module OnlinePaymentPlatform
  class Client
    extend Methods

    def self.status
      fetch URI.parse('https://api-sandbox.onlinebetaalplatform.nl/status')
    end
  end
end
