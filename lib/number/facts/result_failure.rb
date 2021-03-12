# frozen_string_literal: true

module Number
  module Facts
    class ResultFailure < Result
      attr_reader :message

      def initialize(message: 'Unknown reason')
        @message = message
        @success = false
      end

      def to_s
        message.to_s
      end
    end
  end
end
