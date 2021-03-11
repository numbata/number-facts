# frozen_string_literal: true

require 'number/facts/version'

module Number
  module Facts
    Error = Class.new(StandardError)

    class << self
      def fetch(number = :random, **options)
        {text: number, type: :trivia, number: number, found: true}
      end
    end
  end
end
