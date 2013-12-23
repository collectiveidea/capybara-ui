require "spec_helper"

describe Capybara::UI do
  describe ".path" do
    let(:foo_page) { double(:page, current_path: "/foo") }
    let(:bar_page) { double(:page, current_path: "/bar") }
    let(:ui) { Class.new(Capybara::UI) }

    it "matches strings" do
      ui.path("/foo")

      expect(ui.matches?(foo_page)).to be_true
      expect(ui.matches?(bar_page)).to be_false
    end

    it "matches regular expressions" do
      ui.path(/bar/)

      expect(ui.matches?(foo_page)).to be_false
      expect(ui.matches?(bar_page)).to be_true
    end
  end

  describe ".matches?" do
    let(:foo_page) { double(:page, current_path: "/foo") }
    let(:bar_page) { double(:page, current_path: "/bar") }
    let(:ui) { Class.new(Capybara::UI) }

    it "is false if no path is defined" do
      expect(ui.matches?(foo_page)).to be_false
      expect(ui.matches?(bar_page)).to be_false
    end
  end
end
