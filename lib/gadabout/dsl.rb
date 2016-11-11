require 'gadabout/dsl/base'
require 'gadabout/dsl/job'
require 'gadabout/dsl/constraint'
require 'gadabout/dsl/task_group'
require 'gadabout/dsl/task'
require 'gadabout/dsl/log_config'
require 'gadabout/dsl/restart_policy'
require 'gadabout/dsl/resources'
require 'gadabout/dsl/artifact'
require 'gadabout/dsl/network'
require 'gadabout/dsl/periodic'

module Gadabout
  module DSL
    def self.job(&block)
      Gadabout::DSL::Job.new &block
    end
  end
end
