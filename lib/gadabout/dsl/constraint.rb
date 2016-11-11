module Gadabout
  module DSL
    class Constraint < Base
      def initialize
        @l_target = nil
        @r_target = nil
        @operator = nil
      end

      def l_target(l_target)
        @l_target = l_target
      end

      def r_target(r_target)
        @r_target = r_target
      end

      def operator(operator)
        @operator = operator
      end
    end
  end
end
