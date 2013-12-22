module Capybara
  class UI
    module Reload
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def has_capybara_ui_session(&block)
          @capybara_ui_session_finder = block
        end

        def capybara_ui_session_finder
          @capybara_ui_session_finder ||= proc { |instance, session| }
        end
      end

      def capybara_ui_reload
        capybara_ui_session.reload_ui if capybara_ui_session
      end

      private

      def capybara_ui_session
        return @capybara_ui_session if defined? @capybara_ui_session
        @capybara_ui_session = find_capybara_ui_session
      end

      def find_capybara_ui_session
        Capybara::UI.find_session(&capybara_ui_session_finder)
      end

      def capybara_ui_session_finder
        self.class.capybara_ui_session_finder.curry[self]
      end
    end
  end
end
