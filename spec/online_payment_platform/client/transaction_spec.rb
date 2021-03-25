# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlinePaymentPlatform::Client do
  before :all do
    OnlinePaymentPlatform.configure do |config|
      config.api_key = 'test-1234'
    end

    stub_request(:post, 'https://api-sandbox.onlinebetaalplatform.nl/v1/merchants')
      .to_return(status: 200, body: File.read('spec/fixtures/client/merchant_find.txt'))

    payload = {
      emailaddress: 'test@test.com',
      phone: '0612345678',
      country: 'nld',
      notify_url: 'https://test.com/notify_url'
    }

    @merchant = OnlinePaymentPlatform::Client.merchants.create(payload)
  end

  describe '#create' do
    it 'Should raise error when required keys are missing' do
      expect { @merchant.transactions.create }.to raise_error(RuntimeError, 'Required key missing!')
    end

    it 'Should create a transaction' do
      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions").
         to_return(body: File.read('spec/fixtures/client/transaction.txt'))

      payload = {
        total_price: 10000,
        products: [{
          name: 'all products', price: 10000
        }]
      }

      transaction = @merchant.transactions.create payload
      expect(transaction['uid']).to eq('tra_123456')
    end
  end
end
