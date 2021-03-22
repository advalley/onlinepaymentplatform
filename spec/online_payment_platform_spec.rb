# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlinePaymentPlatform do
  it 'has a version number' do
    expect(OnlinePaymentPlatform::VERSION).not_to be nil
  end

  describe '#configure' do
    before :all do
      OnlinePaymentPlatform.configure do |config|
        config.api_key      = 'mock-api-key'
      end
    end

    it 'Should yield from the configuration block' do
      expect(OnlinePaymentPlatform.configuration.api_key).to eq('mock-api-key')
    end

    it 'Should set a default base_uri' do
      expect(OnlinePaymentPlatform.configuration.base_uri).to eq('https://api-sandbox.onlinebetaalplatform.nl/v1/')
    end

    it 'Should be able to override the default base_uri' do
      OnlinePaymentPlatform.configure do |config|
        config.api_key      = 'mock-api-key'
        config.base_uri     = 'https://mock-base-uri.com'
      end

      expect(OnlinePaymentPlatform.configuration.base_uri).to eq('https://mock-base-uri.com')
    end
  end
end
