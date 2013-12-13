class BarPage < Capybara::UI
  def self.matches?(page)
    page.current_path =~ /bar/
  end

  def click_foo
    click_link "Foo"
  end
end
