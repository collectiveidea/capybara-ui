class FooPage < Capybara::UI::Page
  path /foo/

  def click_bar
    click_link "Bar"
  end
end
