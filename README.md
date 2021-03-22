# Ruby wrapper for the postcode.eu endpoints
https://www.postcode.nl/en/services/adresdata/international

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'international_postcode_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install international_postcode_api

## Usage

Create an initializer (config/intializers/international_postcode_api.rb)

```ruby
InternationalPostcodeApi.configure do |config|
  config.api_key      = 'your-API-key'
  config.secret_key   = 'your-secret-key'

  # set new base_uri if new versions are released
  # config.base_uri = 'https://api.postcode.eu/international/v1'

  # Do not switch to Dutch endpoint for Dutch requests will dynamicly switch by default
  # config.dynamic_endpoints = false
end
```

## Methods

All methods can be called from the client object:
```ruby
  InternationalPostcodeApi::Client.autocomplete('Amsterdam', 'nld')
  required: term
  optional: country_code, default: 'nld'

  InternationalPostcodeApi::Client.details('$1234...')
  required: context

  InternationalPostcodeApi::Client.dutch_postcode('1000AB', '50', 'A')
  required: zipcode, house_number
  optional: house_number_addition, default: nil

  # important!! #postcode only returns a hash with :street and :city dynamicly depending on
  # which endpoint you are using, if you need access to the raw response use #dutch_postcode or #autocomplete + #details

  InternationalPostcodeApi::Client.postcode('1000AB', '50', 'DE')
  required: zipcode, house_number
  optional: country_code, default: 'NL'

  InternationalPostcodeApi::Client.supported_countries
```
