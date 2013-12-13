class FooPage < Capybara::UI
  def self.matches?(page)
    page.current_path =~ /foo/
  end

  def click_bar
    click_link "Bar"
  end
end
