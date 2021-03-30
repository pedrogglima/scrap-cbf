# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrap_cbf/version'

Gem::Specification.new do |spec|
  spec.name          = 'scrap_cbf'
  spec.version       = ScrapCbf::VERSION
  spec.authors       = ['Pedro Lima']
  spec.email         = ['pedrogglima@gmail.com']

  spec.summary       = 'ScrapCbf scraps data from the official CBF page.'
  spec.description   = 'With ScrapCbf you will be able to scrap data from the official CBF page. Some of these data are: rounds, matches, rankings table and teams that participated on the CBF 2012 until now, from serie A and B.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb', 'lib/scrap_cbf/samples/*.html']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.1.0'
  spec.add_dependency 'forwardable', '~> 1.2.0'
  spec.add_dependency 'json', '~> 2.1.0'
  spec.add_dependency 'nokogiri', '~> 1.10.3'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 12.3.2'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
  spec.add_development_dependency 'yard', '~> 0.9'
end
