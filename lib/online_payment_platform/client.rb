# frozen_string_literal: true

require 'net/https'
require 'json'
require 'online_payment_platform/methods'
require 'online_payment_platform/client/transaction'

module OnlinePaymentPlatform
  class Client
    extend Methods
  end
end
