# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OnlinePaymentPlatform::Client do
  before :all do
    OnlinePaymentPlatform.configure do |config|
      config.api_key = 'test-1234'
    end
  end

  describe '#create' do
    it 'should raise error when required keys are missing' do
      expect { OnlinePaymentPlatform::Client.transactions.create }.to raise_error(RuntimeError, 'Required key missing!')
    end
  end
end
