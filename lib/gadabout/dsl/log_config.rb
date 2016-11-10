module Gadabout
  module DSL
    class LogConfig < Base
      def initialize
        @max_files = nil
        @max_file_size_m_b = nil
      end

      def max_files(max_files)
        @max_files = max_files
      end

      def max_file_size(max_file_size)
        @max_file_size_m_b = max_file_size
      end
    end
  end
end
