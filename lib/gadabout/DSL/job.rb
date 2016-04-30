require 'json'

module Gadabout
  module DSL
    class Job
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

        puts self.to_h.to_json
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

        return map
      end
    end
  end
end
