class LoginForm < Capybara::UI::Element
  selector "#login"

  def email=(email)
    node.fill_in("Email", with: email)
  end

  def email
    node.find_field("Email").value
  end

  def password=(password)
    node.fill_in("Password", with: password)
  end

  def password
    node.find_field("Password").value
  end
end
