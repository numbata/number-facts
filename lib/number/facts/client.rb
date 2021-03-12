# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Number
  module Facts
    class Client
      API_ENDPOINT = 'http://numbersapi.com'
      TIMEOUT = 10

      attr_reader :api_endpoint

      def initialize(**options)
        @api_endpoint = options[:api_endpoint]
      end

      def request(number: :random, type: :trivia, **input)
        options = input.dup
        options.delete(:fragment) unless options[:fragment]

        response = connection.send(:get, "#{number}/#{type}", options)

        build_result(response)
      rescue ::Faraday::Error => e
        raise Number::Facts::Error, e
      end

      private

      def build_result(response)
        return Number::Facts::ResultFailure.new(message: :fact_not_found) unless response.success?

        json = response.body
        result = json
          .slice(:text, :found, :date, :year)
          .merge(type: json[:type].to_sym, number: json[:number].to_i)

        Number::Facts::ResultSuccess.new(**result)
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
