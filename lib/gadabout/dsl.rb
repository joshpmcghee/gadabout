module Gadabout
  module DSL
    def job(&block)
      Gadabout::DSL::Job.new &block
    end
  end
end
