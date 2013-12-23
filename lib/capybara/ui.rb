require "capybara"
require "capybara/ui/element"
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

    def self.path(path)
      @path = path
    end

    def self.matches?(page)
      @path === page.current_path
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

    def self.has_many(name, options = {})
      options[:type] = :many

      association(name, options)

      define_method(name) do
        page.all(options[:class].selector).map { |node| options[:class].new(node) }
      end
    end

    def self.has_one(name, options = {})
      options[:type] = :one

      association(name, options)

      define_method(name) do
        options[:class].new(page.find(options[:class].selector))
      end
    end

    def self.association(name, options = {})
      options[:class] ||= const_get(options.delete(:class_name))

      associations[name] = options
    end

    def self.associations
      @associations ||= {}
    end

    def initialize(page)
      @page = page
    end

    def reload
      page.reload_ui
      page.ui
    end
  end
end
