class LoginPage < Capybara::UI
  path /login/

  has_one :form, class_name: "LoginForm"
end
