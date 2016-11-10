module Gadabout
  module DSL
    class RestartPolicy < Base
      def initialize
        @attempts = nil
        @interval = nil
        @delay = nil
        @mode = nil
      end

      def attempts(attempts)
        @attempts = attempts
      end

      def interval(interval)
        @interval = interval
      end

      def delay(delay)
        @delay = delay
      end

      def mode(mode)
        @mode = mode
      end
    end
  end
end
