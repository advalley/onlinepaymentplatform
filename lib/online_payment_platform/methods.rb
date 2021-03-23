# frozen_string_literal: true

module Methods
  def assert_required_keys!(options, *keys)
    keys.each do |key|
      raise 'Required key missing!' if options[key].nil?
    end
  end

  def assert_one_of!(options, *keys)
    raise 'Missing one of required keys!' unless (options.keys & keys).any?
  end

  def generate_uri(*path)
    encoded_uri = URI.encode(OnlinePaymentPlatform.configuration.base_uri + path.join('/'))
    URI.parse encoded_uri
  end

  def post(uri, payload = {})
    config = OnlinePaymentPlatform.configuration

    req = Net::HTTP::Post.new(uri, { 'Content-Type': 'text/json' })
    req['Authorization'] = "Bearer #{config.api_key}"
    req.body = payload.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request req
    end

    JSON.parse response.body
  end

  def fetch(uri)
    config = OnlinePaymentPlatform.configuration

    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{config.api_key}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request req
    end

    JSON.parse response.body
  end
end
