# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlinePaymentPlatform::Client do
  before :all do
    OnlinePaymentPlatform.configure do |config|
      config.api_key = 'test-1234'
    end
  end

  describe '#status' do
    it 'should work' do
      stub_request(:get, 'https://api-sandbox.onlinebetaalplatform.nl/status')
        .to_return(status: 200, body: File.read('spec/fixtures/client/status.txt'))

      expect(OnlinePaymentPlatform::Client.status).to eq({ 'date' => 1_616_426_280, 'status' => 'online' })
    end
  end
end
