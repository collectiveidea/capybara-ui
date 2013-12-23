require "spec_helper"

describe Capybara::UI do
  describe ".matches?" do
    let(:foo_page) { double(:page, current_path: "/foo") }
    let(:bar_page) { double(:page, current_path: "/bar") }
    let(:ui) { Class.new(Capybara::UI) }

    after do
      Capybara::UI.subclasses.delete(ui)
    end

    it "is false if no path is defined" do
      expect(ui.matches?(foo_page)).to be_false
      expect(ui.matches?(bar_page)).to be_false
    end

    it "matches string paths" do
      ui.path("/foo")

      expect(ui.matches?(foo_page)).to be_true
      expect(ui.matches?(bar_page)).to be_false
    end

    it "matches regular expression paths" do
      ui.path(/bar/)

      expect(ui.matches?(foo_page)).to be_false
      expect(ui.matches?(bar_page)).to be_true
    end
  end
end
