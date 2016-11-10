module Gadabout
  module DSL
    class Artifact < Base
      def initialize
        @getter_source = nil
        @relative_dest = nil
        @getter_options = {}
      end

      def source(source)
        @getter_source = source
      end

      def relative_dest(relative_dest)
        @relative_dest = relative_dest
      end

      def option(key, value)
        @getter_options[key] = value
      end
    end
  end
end
