module Capybara
  class UI
    class Element
      attr_reader :node

      def self.selector(selector = nil)
        if selector
          @selector = selector
        else
          @selector
        end
      end

      def self.string(name, options = {})
        options[:type] = :string

        attribute(name, options)
      end

      def self.attribute(name, options = {})
        selector = options[:selector] ||= "." << name.to_s.tr("_", "-")
        parser = options[:parser] ||= proc { |node| node.text }

        define_method(name) do
          parser.call(node.find(selector))
        end

        attributes[name] = options
      end

      def self.attributes
        @attributes ||= {}
      end

      def initialize(node)
        @node = node
      end
    end
  end
end
