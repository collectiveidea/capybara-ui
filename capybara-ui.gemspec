# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "capybara-ui"
  spec.version = "0.0.1"

  spec.author      = "Collective Idea"
  spec.email       = "info@collectiveidea.com"
  spec.description = "Capybara::Ui gives you page objects to help make your acceptance tests readable and resilient."
  spec.summary     = "Page objects for readable, resilient acceptance tests"
  spec.homepage    = "https://github.com/collectiveidea/capybara-ui"
  spec.license     = "MIT"

  spec.files      = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
end
