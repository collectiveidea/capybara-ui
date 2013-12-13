require "capybara/rspec"

Capybara.app = Rack::Builder.app do
  # Serve HTML files from spec/support/app
  use Rack::Static, root: File.expand_path("../app", __FILE__), urls: ["/"]
  map "/"
end
