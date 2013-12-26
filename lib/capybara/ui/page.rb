module Capybara
  module UI
    class Page
      include Capybara::DSL

      attr_reader :page

      def self.inherited(subclass)
        Capybara::UI::Page.subclasses << subclass
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

      def self.for(page)
        subclass_for_page(page).new(page)
      end

      def self.subclass_for_page(page)
        subclasses.detect { |s| s.matches?(page) } || (raise NoMatch)
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
end
