require "spec_helper"

feature "Capybara" do
  scenario "UI is loaded before interacting with a page" do
    visit "/foo.html"

    expect {
      ui.click_bar
    }.to change {
      page.current_path
    }
  end

  scenario "UI is automatically reloaded when following links" do
    visit "/foo.html"

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
    visit "/foo.html"

    using_session :other do
      visit "/foo.html"
      ui.click_bar

      expect(ui.class).to eq(BarPage)
    end

    expect(ui.class).to eq(FooPage)
  end

  scenario "UI is reloaded when the session is reset" do
    visit "/foo.html"

    page.reset!

    expect { ui }.to raise_error(Capybara::UI::NoMatch)

    visit "/foo.html"

    expect(ui.class).to eq(FooPage)
  end

  scenario "UI can load plural associations" do
    visit "/table.html"

    ui_people = ui.people
    expect(ui_people).to have(4).people
    expect(ui_people[0].name).to eq("Daniel Morrison")
    expect(ui_people[1].name).to eq("Brian Ryckbost")
    expect(ui_people[2].name).to eq("Chris Gaffney")
    expect(ui_people[3].name).to eq("Steve Richert")
  end
end
