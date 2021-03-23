# frozen_string_literal: true

require 'online_payment_platform/version'
require 'online_payment_platform/client'
require 'online_payment_platform/client/status'
require 'online_payment_platform/client/merchant'

module OnlinePaymentPlatform
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key, :base_uri, :sandbox_mode

    def initialize
      @sandbox_mode = true
      @base_uri = @sandbox_mode ? 'https://api-sandbox.onlinebetaalplatform.nl/v1/' : 'https://api.onlinebetaalplatform.nl/v1/'
    end
  end
end
