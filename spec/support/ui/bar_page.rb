class BarPage < Capybara::UI
  path "/bar.html"

  def click_foo
    click_link "Foo"
  end
end
