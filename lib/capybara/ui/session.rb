module Capybara
  class UI
    module Session
      def self.included(base)
        base.class_eval do
          alias_method :reset_without_capybara_ui_reload!, :reset!
          alias_method :reset!, :reset_with_capybara_ui_reload!
        end
      end

      def ui
        @ui ||= Capybara::UI.for_page(self)
      end

      def reload_ui
        @ui = nil
      end

      def reset_with_capybara_ui_reload!
        reload_ui
        reset_without_capybara_ui_reload!
      end
    end
  end
end

Capybara::Session.send(:include, Capybara::UI::Session)
