require 'international_postcode_api/version'
require 'international_postcode_api/client'
require 'securerandom'

module InternationalPostcodeApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key, :secret_key, :base_uri, :dynamic_endpoints
    attr_reader :session_token

    def initialize
      @base_uri = 'https://api.postcode.eu/international/v1/'
      @session_token = SecureRandom.hex(8)
      @dynamic_endpoints = true
    end
  end
end
