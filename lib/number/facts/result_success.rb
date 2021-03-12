# frozen_string_literal: true

module Number
  module Facts
    class ResultSuccess < Result
      attr_reader :fact

      def initialize(fact)
        @fact = fact
        @success = true

        fact[:number] = fact[:number].to_i if fact.key?(:number)
        fact[:type] = fact[:type].to_sym if fact.key?(:type)
      end

      def number
        fact[:number]
      end

      def type
        fact[:type]
      end

      def text
        fact[:text]
      end

      def found
        fact[:found]
      end

      def year
        fact[:year]
      end

      def year
        fact[:date]
      end

      def to_s
        fact.to_s
      end

      def to_json
        fact.to_json
      end
    end
  end
end
