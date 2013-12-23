require "spec_helper"

feature "Capybara" do
  background do
    visit "/foo.html"
  end

  scenario "UI is loaded before interacting with a page" do
    expect {
      ui.click_bar
    }.to change {
      page.current_path
    }
  end

  scenario "UI is automatically reloaded when following links" do
    expect {
      ui.click_bar
    }.to change {
      ui.class
    }.from(FooPage).to(BarPage)

    expect {
      ui.click_foo
    }.to change {
      ui.class
    }.from(BarPage).to(FooPage)
  end

  scenario "UI is reloaded independently per session" do
    using_session :other do
      visit "/foo.html"
      ui.click_bar

      expect(ui.class).to eq(BarPage)
    end

    expect(ui.class).to eq(FooPage)
  end

  scenario "UI is reloaded when the session is reset" do
    page.reset!

    expect { ui }.to raise_error(Capybara::UI::NoMatch)

    visit "/foo.html"

    expect(ui.class).to eq(FooPage)
  end
end
