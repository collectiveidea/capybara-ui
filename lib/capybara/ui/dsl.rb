module Capybara
  module UI
    module DSL
      def ui
        page.ui
      end
    end
  end
end

Capybara::DSL.send(:include, Capybara::UI::DSL)
