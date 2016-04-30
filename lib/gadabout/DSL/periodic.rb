module Gadabout
  module DSL
    class Periodic < Base
      def initialize
        @enabled = nil
        @spec = nil
        @spec_type = nil
        @prohibit_overlap = nil
      end

      def enabled(enabled)
        @enabled = enabled
      end

      def prohibit_overlap(prohibit_overlap)
        @prohibit_overlap = prohibit_overlap
      end

      def spec_type(spec_type)
        @spec_type = spec_type
      end

      def spec(spec)
        @spec = spec
      end
    end
  end
end
