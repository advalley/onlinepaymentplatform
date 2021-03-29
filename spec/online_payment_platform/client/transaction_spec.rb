# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlinePaymentPlatform::Client do
  before :all do
    OnlinePaymentPlatform.configure do |config|
      config.api_key = 'test-1234'
    end

    stub_request(:post, 'https://api-sandbox.onlinebetaalplatform.nl/v1/merchants')
      .to_return(status: 200, body: File.read('spec/fixtures/client/merchant_find.txt'))

    stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions").
       to_return(body: File.read('spec/fixtures/client/transaction.txt'))

    transaction_payload = {
        total_price: 10000,
        products: [{
          name: 'all products', price: 10000
        }]
      }

    merchant_payload = {
      emailaddress: 'test@test.com',
      phone: '0612345678',
      country: 'nld',
      notify_url: 'https://test.com/notify_url'
    }

    @merchant = OnlinePaymentPlatform::Client.merchants.create(merchant_payload)
    @transaction = @merchant.transactions.create transaction_payload
  end

  describe '#create' do
    it 'Should raise error when required keys are missing' do
      expect { @merchant.transactions.create }.to raise_error(RuntimeError, 'Required key missing!')
    end

    it 'Should create a transaction' do
      expect(@transaction['uid']).to eq('tra_123456')
    end
  end

  describe '#find' do
    it 'Should return a specific payment' do
      stub_request(:get, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions/tra_123456").
         to_return(body: File.read('spec/fixtures/client/transaction.txt'))

      transaction = @merchant.transactions.find('tra_123456')
      expect(transaction.uid).to eq('tra_123456')
    end
  end

  describe '#refund!' do
    it 'Should refund the payment' do
      stub_request(:get, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions/tra_123456").
         to_return(body: File.read('spec/fixtures/client/transaction.txt'))

      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions/tra_123456/refunds").
         to_return(body: File.read('spec/fixtures/client/transaction_refund.txt'))

      transaction = @merchant.transactions.find('tra_123456')
      response = transaction.refund!(amount: 21500)
      expect(response['uid']).to eq('ref_123456')
    end
  end

  describe '#refunds' do
    it 'Should list the refunds' do
      stub_request(:get, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions/tra_123456").
         to_return(body: File.read('spec/fixtures/client/transaction.txt'))

      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions/tra_123456/refunds").
         to_return(body: File.read('spec/fixtures/client/transaction_refund.txt'))

      stub_request(:get, "https://api-sandbox.onlinebetaalplatform.nl/v1/transactions/tra_123456/refunds").
        to_return(body: File.read('spec/fixtures/client/transaction_refund_list.txt'))

      transaction = @merchant.transactions.find('tra_123456')
      expect(transaction.refunds['data'].count).to eq(1)
    end
  end
end

