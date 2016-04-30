module Gadabout
  module DSL
    class Network < Base
      def initialize
        @reserved_ports = []
        @dynamic_ports = []
        @m_bits = nil
      end

      def reserved_port(label, port)
        @reserved_ports << {label: label, value: port}
      end

      def dynamic_port(label)
        @dynamic_ports << {label: label}
      end

      def m_bits(m_bits)
        @m_bits = m_bits
      end
    end
  end
end
