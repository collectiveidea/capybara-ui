require "capybara"
require "capybara/ui/session"
require "capybara/ui/dsl"
require "capybara/ui/reload"
require "capybara/ui/page"
require "capybara/ui/drivers/rack_test"
require "capybara/ui/drivers/poltergeist"

module Capybara
  module UI
    class Error < StandardError; end
    class NoMatch < Error; end

    def self.find_session(&block)
      sessions.find(&block)
    end

    def self.sessions
      Capybara.send(:session_pool).values
    end
  end
end
