# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Number
  module Facts
    class Client
      API_ENDPOINT = 'http://numbersapi.com'
      TIMEOUT = 10

      def request(number:, type: :trivia, **options)
        endpoint_path = "#{number}/#{type}"
        response = connection.send(:get, endpoint_path, options)

        response.body
      rescue FaradayError => e
        raise Number::Facts::Error, e
      end

      private

      def connection
        Faraday.new(url: API_ENDPOINT, request: { timeout: TIMEOUT }) do |f|
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
