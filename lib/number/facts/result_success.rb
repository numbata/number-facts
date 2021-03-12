# frozen_string_literal: true

module Number
  module Facts
    class ResultSuccess < Result
      attr_reader :fact

      def initialize(fact)
        super

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

      def date
        fact[:date]
      end

      def to_s
        fact.to_s
      end

      def to_json(*args)
        JSON.generate(fact, *args)
      end
    end
  end
end
