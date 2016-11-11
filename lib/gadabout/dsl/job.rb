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
        @id = nil
        @periodic = nil
        @priority = 50
        @region = "global"
        @type = "service"
        @update = nil
        @datacenters = []

        instance_eval &block if block_given?
      end

      def task_group(&block)
        tg = TaskGroup.new

        tg.instance_eval &block

        @task_groups << tg
      end

      def constraint(&block)
        c = Constraint.new

        c.instance_eval &block

        @constraints << c
      end

      def periodic
        p = Periodic.new

        p.instance_eval &block

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

      def type(type)
        @type = type
      end

      def id(id)
        @id = id
      end

      def priority(priority)
        @priority = priority
      end

      def all_at_once(all_at_once)
        @all_at_once = all_at_once
      end

      def datacenters(*datacenters)
        @datacenters = datacenters
      end
    end
  end
end
