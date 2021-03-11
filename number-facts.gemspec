# frozen_string_literal: true

require_relative 'lib/number/facts/version'

Gem::Specification.new do |spec|
  spec.name          = 'number-facts'
  spec.version       = Number::Facts::VERSION
  spec.authors       = ['Andrei Subbota']
  spec.email         = ['subbota@gmail.com']

  spec.summary       = %q{Interface for numbersapi.com}
  spec.description   = %q{Playground to iteract with github actions}
  spec.homepage      = 'https://github.com/numbata/number-facts'
  spec.required_ruby_version = Gem::Requirement.new('>= 2')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/commits"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
