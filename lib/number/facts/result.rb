# frozen_string_literal: true

module Number
  module Facts
    class Result
      attr_reader :success

      def success?
        @success == true
      end

      def failure?
        @success == false
      end
    end
  end
end
