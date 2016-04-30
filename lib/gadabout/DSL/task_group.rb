module Gadabout
  module DSL
    class TaskGroup
      def initialize
        @constraints = []
        @count = 0
        @meta = {}
        @name = nil
        @restart_policy = nil
        @tasks = []
      end

      def task
        t = Task.new

        yield t

        @tasks << t
      end

      def constraint
        c = Constraint.new

        yield c

        @constraints << c
      end

      def restart_policy
        rp = RestartPolicy.new

        yield rp

        @restart_policy = rp
      end

      def meta(key, value)
        @meta[key] = value
      end

      def name(name)
        @name = name
      end

      def count(count)
        @count = count
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

        return map
      end
    end
  end
end
