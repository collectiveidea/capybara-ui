module Capybara
  class UI
    module Session
      def ui
        @ui ||= Capybara::UI.for_page(self)
      end

      def reload_ui
        @ui = nil
      end
    end
  end
end

Capybara::Session.send(:include, Capybara::UI::Session)
