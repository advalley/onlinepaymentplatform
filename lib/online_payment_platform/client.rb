# frozen_string_literal: true

require 'net/https'
require 'json'
require 'online_payment_platform/methods'

module OnlinePaymentPlatform
  class Client
    extend Methods
  end
end
