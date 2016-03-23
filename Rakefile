require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :install do
  sh 'gem build ./gadabout.gemspec'
  sh 'gem install gadabout-*.gem --no-rdoc --no-ri'
  sh 'rm gadabout-*.gem'
end

task :default => :test
