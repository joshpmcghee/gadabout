module Gadabout
  module Spec
    class Job
      attr_accessor :datacenters, :all_at_once

      def initialize(&block)
        instance_eval &block
      end

      def task_group(name = @name)
        @task_groups << TaskGroup.new(name)
      end

      def constraint
        @constraints << Constraint.new
      end

      def meta(key, value)
        @meta[key] = value
      end

      def to_json

      end
    end
  end
end
