require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*.rb'
  t.rcov = false
  t.verbose = true
end

desc "Run tests"
task :default => :spec
task :default => :build