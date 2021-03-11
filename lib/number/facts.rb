# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'number/facts/version'

module Number
  module Facts
    API_ENDPOINT = 'http://numbersapi.com'
    TIMEOUT = 10

    Error = Class.new(StandardError)

    class << self
      def fetch(number = :random, type: :trivia, **options)
        endpoint_path = "#{number}/#{type}"
        response = connection.send(:get, endpoint_path, options)

        response.body
      end

      def connection
        @connection ||= Faraday.new(url: API_ENDPOINT, request: {timeout: TIMEOUT}) do |f|
          f.request :json
          f.response :json,
            content_type: /\bjson$/,
            parser_options: { symbolize_names: true }
          f.headers['Content-Type'] = 'application/json'
          f.adapter Faraday.default_adapter
        end
      end
    end
  end
end
