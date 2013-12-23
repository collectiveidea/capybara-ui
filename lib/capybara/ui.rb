require "capybara"
require "capybara/ui/session"
require "capybara/ui/dsl"
require "capybara/ui/reload"
require "capybara/ui/drivers/rack_test"
require "capybara/ui/drivers/poltergeist"

module Capybara
  class UI
    class Error < StandardError; end
    class NoMatch < Error; end

    include Capybara::DSL

    attr_reader :page

    def self.inherited(subclass)
      Capybara::UI.subclasses << subclass
    end

    def self.subclasses
      @subclasses ||= []
    end

    def self.for_page(page)
      subclass_for_page(page).new(page)
    end

    def self.subclass_for_page(page)
      subclasses.detect { |s| s.matches?(page) } || (raise NoMatch)
    end

    def self.find_session(&block)
      sessions.find(&block)
    end

    def self.sessions
      Capybara.send(:session_pool).values
    end

    def initialize(page)
      @page = page
    end

    def reload
      page.reload_ui
    end
  end
end
