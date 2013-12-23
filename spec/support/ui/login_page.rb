require "support/ui/login_form"

class LoginPage < Capybara::UI
  path "/login.html"

  has_one :form, class_name: "LoginForm"
end
