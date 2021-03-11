# frozen_string_literal: true

require 'bundler/setup'
require 'number/facts'

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :faraday
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  default_options = {
    match_requests_on: %i[method path body]
  }
  default_options[:record] = :all if ENV['VCR_UP']
  config.default_cassette_options = default_options
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
