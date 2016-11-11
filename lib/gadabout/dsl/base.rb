module Gadabout
  module DSL
    class Base
      def initialize
      end

      def to_h
        map = {}

        self.instance_variables.each do |var|
          val = instance_variable_get(var)

          next if val.nil?
          if val.instance_of? Array
            next if val.empty?
          end

          unless [String, Fixnum, Hash, Array, TrueClass, FalseClass].include? val.class
            val = val.to_h
          else
            # Check within Arrays and Hashes for other incomprehensibles
            if val.instance_of? Array
              val.map! do |i|
                unless [String, Fixnum, Hash, Array, TrueClass, FalseClass].include? i.class
                  i.to_h
                else
                  i
                end
              end
            elsif val.instance_of? Hash
              val.each_pair do |k,v|
                unless [String, Fixnum, Hash, Array, TrueClass, FalseClass].include? v.class
                  val[k] = v.to_h
                end
              end
            end
          end

          # Convert keys from ruby instance_var to Hashicorp JSON-syntax key
          hashivar = var[1..-1].to_s.split('_').map{ |w| w.capitalize }.join('')
          map[hashivar] = val
        end

        return map
      end
    end
  end
end
