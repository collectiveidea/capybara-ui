require "capybara/rack_test/browser"

Capybara::RackTest::Browser.class_eval do
  def reset_cache_with_ui_reload!
    session = Capybara::UI.find_session { |s| s.driver.browser == self }
    session.reload_ui if session
    reset_cache_without_ui_reload!
  end

  alias_method :reset_cache_without_ui_reload!, :reset_cache!
  alias_method :reset_cache!, :reset_cache_with_ui_reload!
end
