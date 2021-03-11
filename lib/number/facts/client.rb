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

        build_result(response)
      rescue FaradayError => e
        raise Number::Facts::Error, e
      end

      private

      def build_result(response)
        return unless response.success?

        json = response.body
        json
          .slice(:text, :found, :date, :year)
          .merge(type: json[:type].to_sym, number: json[:number].to_i)
      end

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
