# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendgrid_template/version'

Gem::Specification.new do |spec|
  spec.name          = 'sendgrid_template'
  spec.version       = SendgridTemplate::VERSION
  spec.authors       = ['Maxim Pechnikov']
  spec.email         = ['parallel588@gmail.com']
  spec.summary       = 'Sendgrid Template'
  spec.description   = 'Sendgrid Template'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency('vcr', '~> 2.9')
  spec.add_development_dependency('webmock', '~> 1.8.0')
  spec.add_dependency 'faraday', '~> 1.6.0'
  spec.add_dependency 'multi_json', '~> 1.13'
end
