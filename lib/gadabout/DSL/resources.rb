module Gadabout
  module DSL
    class Resources
      def initialize
        @cpu = nil
        @disk_m_b = nil
        @iops = nil
        @memory_m_b = nil
        @networks = []
      end

      def network
        n = Network.new

        yield n

        @networks << n
      end

      def cpu(cpu)
        @cpu = cpu
      end

      def memory(memory)
        @memory_m_b = memory
      end

      def iops(iops)
        @iops = iops
      end

      def disk(disk)
        @disk_m_b = disk
      end
    end
  end
end
