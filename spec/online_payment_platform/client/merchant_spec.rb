# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlinePaymentPlatform::Client do
  before :all do
    OnlinePaymentPlatform.configure do |config|
      config.api_key = '7065b4c799838ed4c6e9f055816991b1'
    end
  end

  describe '#migrate' do
    before(:each) do
      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_find.txt'))

      payload = {
        emailaddress: 'test@test.com',
        phone: '0612345678',
        country: 'nld',
        notify_url: 'https://test.com/notify_url'
      }

      @merchant = OnlinePaymentPlatform::Client.merchants.create(payload)
    end

    it 'Should throw an error when missing required keys' do
      expect{ @merchant.migrate }.to raise_error(RuntimeError, 'Required key missing!')
    end

    it 'Should migrate the merchant' do
      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants/mer_9c747fecac38/migrate").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_migrate.txt'), headers: {})

      response = @merchant.migrate(coc_nr: '987654321', country: 'nld')
      expect(response.features['coc_nr']).to eq('987654321')
    end
  end

  describe '#update' do
    it 'Should throw an error when not given any valid keys' do
      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_find.txt'))

      payload = {
        emailaddress: 'test@test.com',
        phone: '0612345678',
        country: 'nld',
        notify_url: 'https://test.com/notify_url'
      }

      merchant = OnlinePaymentPlatform::Client.merchants.create(payload)
      expect{ merchant.update }.to raise_error(RuntimeError, 'Missing one of required keys!')
    end

    it 'Should throw an error when not given any valid keys' do
      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_find.txt'))
       stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants/mer_9c747fecac38").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_update.txt'), headers: {})

      payload = {
        emailaddress: 'test@test.com',
        phone: '0612345678',
        country: 'nld',
        notify_url: 'https://test.com/notify_url'
      }

      merchant = OnlinePaymentPlatform::Client.merchants.create(payload)
      response = merchant.update(return_url: 'https://example.com/new_return_url')
      expect(response['return_url']).to eq('https://example.com/new_return_url')
    end
  end

  describe 'self#merchants' do
    it 'Should return the Merchants class' do
      expect(OnlinePaymentPlatform::Client.merchants).to eq(OnlinePaymentPlatform::Client::Merchants)
    end
  end

  describe '#create' do
    it 'Should raise an error when keys are missing' do
      expect { OnlinePaymentPlatform::Client.merchants.create }.to raise_error(RuntimeError, 'Required key missing!')
    end

    it 'Should create a merchant if valid' do
      stub_request(:post, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_find.txt'))

      payload = {
        emailaddress: 'test@test.com',
        phone: '0612345678',
        country: 'nld',
        notify_url: 'https://test.com/notify_url'
      }

      merchant = OnlinePaymentPlatform::Client.merchants.create(payload)

      expect(merchant.uid).to eq('mer_9c747fecac38')
    end
  end

  describe '#find' do
    it 'Should return the merchant' do
      stub_request(:get, "https://api-sandbox.onlinebetaalplatform.nl/v1/merchants/mer_9c747fecac38").
         to_return(status: 200, body: File.read('spec/fixtures/client/merchant_update.txt'))

      merchant = OnlinePaymentPlatform::Client.merchants.find('mer_9c747fecac38')

      expect(merchant.uid).to eq('mer_9c747fecac38')
    end
  end
end
