require "capybara/rack_test/browser"

Capybara::RackTest::Browser.class_eval do
  include Capybara::UI::Reload

  has_capybara_ui_session do |browser, session|
    session.driver.instance_variable_get(:@browser) == browser
  end

  def reset_cache_with_capybara_ui_reload!
    capybara_ui_reload
    reset_cache_without_capybara_ui_reload!
  end

  alias_method :reset_cache_without_capybara_ui_reload!, :reset_cache!
  alias_method :reset_cache!, :reset_cache_with_capybara_ui_reload!
end
