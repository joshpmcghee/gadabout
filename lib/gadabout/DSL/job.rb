require 'json'

module Gadabout
  module DSL
    class Job < Base
      def initialize(&block)
        @name = nil
        @task_groups = []
        @constraints = []
        @all_at_once = false
        @meta = {}
        @periodic = nil
        @priority = 50
        @region = "global"
        @type = "service"
        @update = nil

        yield self

        puts JSON.pretty_generate(self.to_h)
      end

      def task_group
        tg = TaskGroup.new

        yield tg

        @task_groups << tg
      end

      def constraint
        c = Constraint.new

        yield c

        @constraints << c
      end

      def periodic
        p = Periodic.new

        yield p

        @periodic = p
      end

      def meta(key, value)
        @meta[key] = value
      end

      def name(name)
        @name = name
      end

      def region(region)
        @region = region
      end

      def all_at_once(all_at_once)
        @all_at_once = all_at_once
      end

      def datacenters(datacenters)
        @datacenters = datacenters
      end
    end
  end
end
