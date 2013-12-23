require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "coveralls/rake/task"

DRIVERS = %w(rack_test poltergeist)

DRIVERS.each do |driver|
  desc "Run RSpec code examples for the #{driver} driver"
  RSpec::Core::RakeTask.new(driver) do
    ENV["DRIVER"] = driver
  end
end

desc "Run RSpec code examples for all drivers"
task spec: DRIVERS

Coveralls::RakeTask.new

task default: [:spec, "coveralls:push"]
