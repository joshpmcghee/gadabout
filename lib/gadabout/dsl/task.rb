module Gadabout
  module DSL
    class Task < Base
      def initialize
        @artifacts = []
        @config = {}
        @name = nil
        @constraints = []
        @driver = nil
        @env = {}
        @meta = {}
        @resources = nil
        @kill_timeout = nil
        @log_config = nil
        @user = nil
      end

      def constraint(&block)
        c = Constraint.new

        c.instance_eval &block

        @constraints << c
      end

      def artifact(&block)
        a = Artifact.new

        a.instance_eval &block

        @artifacts << a
      end

      def log_config(&block)
        lc = LogConfig.new

        lc.instance_eval &block

        @log_config = lc
      end

      def resources(&block)
        r = Resources.new

        r.instance_eval &block

        @resources = r
      end

      def meta(key, value)
        @meta[key] = value
      end

      def env(key, value)
        @env[key] = value
      end

      def name(name)
        @name = name
      end

      def config(key, value)
        @config[key] = value
      end

      def name(name)
        @name = name
      end

      def user(user)
        @user = user
      end

      def driver(driver)
        @driver = driver
      end

      def kill_timeout(kill_timeout)
        @kill_timeout = kill_timeout
      end
    end
  end
end
