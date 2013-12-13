require "capybara/rack_test/browser"

Capybara::RackTest::Browser.class_eval do
  def reset_cache_with_ui!
    Capybara.current_session.reload_ui
    reset_cache_without_ui!
  end

  alias_method :reset_cache_without_ui!, :reset_cache!
  alias_method :reset_cache!, :reset_cache_with_ui!
end
