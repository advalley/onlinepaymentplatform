# frozen_string_literal: true

require_relative 'lib/online_payment_platform/version'

Gem::Specification.new do |spec|
  spec.name          = 'online_payment_platform'
  spec.version       = OnlinePaymentPlatform::VERSION
  spec.authors       = ['Dennis de Vulder']
  spec.email         = ['dennisdevulder@gmail.com']

  spec.summary       = 'A ruby wrapper for OPP'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/advalley/onlinepaymentplatform'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/advalley/onlinepaymentplatform/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'
end
