begin
  require "capybara/poltergeist/browser"
  require "capybara/poltergeist/client"
rescue LoadError
end

if defined?(Capybara::Poltergeist::Browser) && defined?(Capybara::Poltergeist::Client)
  module Capybara
    class UI
      module Poltergeist
        class Listener
          RELOAD_PATTERN = /\Acapybara-ui reload\s*\z/

          def initialize(logger)
            @logger = logger
          end

          def write(data)
            reload?(data) ? reload : log(data)
          end

          private

          def reload?(data)
            data =~ RELOAD_PATTERN
          end

          def reload
            Capybara.current_session.reload_ui
          end

          def log(data)
            @logger.write(data) if @logger
          end
        end
      end
    end
  end

  Capybara::Poltergeist::Browser.class_eval do
    def initialize_with_capybara_ui_extension(*args)
      initialize_without_capybara_ui_extension(*args)
      self.extensions = File.expand_path("../poltergeist.js", __FILE__)
    end

    alias_method :initialize_without_capybara_ui_extension, :initialize
    alias_method :initialize, :initialize_with_capybara_ui_extension
  end

  Capybara::Poltergeist::Client.class_eval do
    def initialize_with_capybara_ui_listener(*args)
      initialize_without_capybara_ui_listener(*args)
      @phantomjs_logger = Capybara::UI::Poltergeist::Listener.new(@phantomjs_logger)
    end

    alias_method :initialize_without_capybara_ui_listener, :initialize
    alias_method :initialize, :initialize_with_capybara_ui_listener
  end
end
