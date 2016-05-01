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

      def task(&block)
        t = Task.new

        t.instance_eval &block

        @tasks << t
      end

      def constraint(&block)
        c = Constraint.new

        c.instance_eval &block

        @constraints << c
      end

      def restart_policy(&block)
        rp = RestartPolicy.new

        rp.instance_eval &block

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
