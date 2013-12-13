require "spec_helper"

feature "Linking" do
  background do
    visit "foo.html"
  end

  scenario "UI is loaded before interacting with a page" do
    expect {
      page.ui.click_bar
    }.to change {
      page.current_path
    }
  end

  scenario "UI is automatically reloaded when following links" do
    expect {
      page.ui.click_bar
    }.to change {
      page.ui.class
    }.from(FooPage).to(BarPage)

    expect {
      page.ui.click_foo
    }.to change {
      page.ui.class
    }.from(BarPage).to(FooPage)
  end
end
