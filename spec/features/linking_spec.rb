require "spec_helper"

feature "Linking" do
  background do
    visit "/foo.html"
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

  scenario "UI is reloaded independently per session" do
    using_session :other do
      visit "/foo.html"
      page.ui.click_bar

      expect(page.ui.class).to eq(BarPage)
    end

    expect(page.ui.class).to eq(FooPage)
  end

  scenario "UI is reloaded when the session is reset" do
    page.reset!

    expect { page.ui }.to raise_error(Capybara::UI::NoMatch)

    visit "/foo.html"

    expect(page.ui.class).to eq(FooPage)
  end
end
