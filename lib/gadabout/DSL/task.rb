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

      def constraint
        c = Constraint.new

        yield c

        @constraints << c
      end

      def artifact
        a = Artifact.new

        yield a

        @artifacts << a
      end

      def log_config
        lc = LogConfig.new

        yield lc

        @log_config = lc
      end

      def resources
        r = Resources.new

        yield r

        @resources = r
      end

      def meta(key, value)
        @meta[key] = value
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
