# frozen_string_literal: true

require 'number/facts/version'
require 'number/facts/client'

module Number
  module Facts
    Error = Class.new(StandardError)

    class << self
      def fetch(number = :random, **options)
        client.request(**options.merge(number: number))
      end

      def client
        @client ||= Client.new
      end
    end
  end
end
