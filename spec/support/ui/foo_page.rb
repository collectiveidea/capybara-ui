class FooPage < Capybara::UI
  path /foo/

  def click_bar
    click_link "Bar"
  end
end
