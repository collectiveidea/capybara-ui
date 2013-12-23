require "coveralls"
Coveralls.wear!

ENV["DRIVER"] ||= "rack_test"

require "capybara/ui"

require "bundler"
Bundler.require(:test)

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }
