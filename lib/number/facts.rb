# frozen_string_literal: true

require 'number/facts/version'
require 'number/facts/client'
require 'number/facts/result'
require 'number/facts/result_success'
require 'number/facts/result_failure'

module Number
  module Facts
    Error = Class.new(StandardError)

    class << self
      def request(**options)
        client.request(**options)
      end

      private

      def client
        @client ||= Client.new
      end
    end
  end
end
