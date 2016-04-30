module Gadabout
  module Specification
    class Job
      attr_accessor :datacenters, :all_at_once

      def initialize(name, action = :build)
        @all_at_once = false
        @constraints = []
        @datacenters = []
        @id = nil
        @meta = {}
        @name = name
        @periodic = {}
        @priority = 50
        @region = "global"
        @task_groups = []
        @type = "service"
        @update = nil

        # Harvest Job spec from Nomad if we're going to manipulate it
        if action == :update
          # TODO: This is scary, leave it 'til last.
          raise "Gadabout resources don't currently support the manipulation of jobs. Come back later."
        end

        yield(self)
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
