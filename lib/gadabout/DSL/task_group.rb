module Gadabout
  module DSL
    class TaskGroup < Base
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
    end
  end
end
