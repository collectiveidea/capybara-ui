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

          def initialize(client, logger = nil)
            @client = client
            @logger = logger
          end

          def write(data)
            reload?(data) ? reload : log(data)
          end

          private

          def session
            return @session if defined? @session
            @session = sessions.detect { |s| s.driver.client == @client }
          end

          def sessions
            Capybara.send(:session_pool).values
          end

          def reload?(data)
            data =~ RELOAD_PATTERN
          end

          def reload
            session.reload_ui if session
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
    def initialize_with_listener(*args)
      initialize_without_listener(*args)
      @phantomjs_logger = Capybara::UI::Poltergeist::Listener.new(self, @phantomjs_logger)
    end

    alias_method :initialize_without_listener, :initialize
    alias_method :initialize, :initialize_with_listener
  end
end
