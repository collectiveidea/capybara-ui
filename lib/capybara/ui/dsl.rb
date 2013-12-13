module Capybara
  class UI
    module DSL
      def ui
        @ui ||= Capybara::UI.for_page(self)
      end

      def ui=(ui)
        @ui = ui
      end

      def reload_ui
        @ui = nil
      end
    end
  end
end
