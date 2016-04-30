module Gadabout
  module DSL
    class Base
      def initialize
      end

      def format_keys(map)
        map.keys.each do |k|
         if map[k].instance_of? Hash
           map[k] = format_keys(map[k])
         end

         new_k = k.split('_').map{ |w| w.capitalize }.join('')
         map[new_k] = map[k]
         map.delete(k)
       end

       return map
      end

      def to_h
        map = {}

        self.instance_variables.each do |var|
          val = instance_variable_get(var)
          next if val.nil?

          unless [String, Fixnum, Hash, Array, TrueClass, FalseClass].include? val.class
            val = val.to_h
          else
            # Check within Arrays and Hashes for other incomprehensibles
            if val.instance_of? Array
              puts "detected array!"
              puts val
              val.map! do |i|
                unless [String, Fixnum, Hash, Array, TrueClass, FalseClass].include? i.class
                  i.to_h
                end
              end
            elsif val.instance_of? Hash
              puts "detected hash!"
              val.each_pair do |k,v|
                unless [String, Fixnum, Hash, Array, TrueClass, FalseClass].include? v.class
                  val[k] = v.to_h
                end
              end
            end
          end

          map[var[1..-1]] = val
        end



        return format_keys(map)
      end
    end
  end
end
