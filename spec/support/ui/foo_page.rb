class FooPage < Capybara::UI
  path "/foo.html"

  def click_bar
    click_link "Bar"
  end
end
