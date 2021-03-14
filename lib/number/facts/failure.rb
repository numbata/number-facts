# frozen_string_literal: true

module Number
  module Facts
    class Failure
      attr_reader :message

      def initialize(message: 'Unknown reason')
        @message = message
      end

      def to_s
        message.to_s
      end

      def success?
        false
      end

      def failure?
        !success?
      end
    end
  end
end
