# Capybara::UI

Capybara::UI gives you page objects to help make your acceptance tests readable and resilient.

## Page Objects

Page objects are Ruby objects that encapsulate any given page in your application.

A Capybara::UI page defines methods to describe a user's interactions with that page.

```ruby
module UI
  class LoginPage < Capybara::UI
    path "/session/new"

    def log_in(email, password)
      self.email = email
      self.password = password
      submit
    end

    def email=(email)
      fill_in("Email", with: email)
    end

    def email
      find_field("Email").value
    end

    def password=(password)
      fill_in("Password", with: password)
    end

    def password
      find_field("Password").value
    end

    def submit
      click_button("Log In")
    end
  end
end
```

### Why Page Objects?

It's helpful to define these interactions in one place so that when the underlying page changes (and it will), you can update this one class rather than finding and updating tests scattered throughout your suite. Well-written page objects make your acceptance tests more resilient to change.

### Usage

A Capybara::UI page has a `path` directive to define when that particular page should be used. When the path of the Capybara session matches, the Capybara::UI will be applied.

Capybara::UI can be used anywhere you use Capybara. Using the login page described above, we can refactor the following test:

```ruby
feature "Login" do
  scenario "A user can log in with the correct email and password." do
    user = create(:user, email: "foo@bar.com", password: "secret")

    visit(login_path)
    fill_in("Email", with: "foo@bar.com")
    fill_in("Password", with: "secret")
    click_button("Log In")

    expect(current_path).to eq(account_path)
  end
end
```

into:

```ruby
feature "Login" do
  scenario "A user can log in with the correct email and password." do
    user = create(:user, email: "foo@bar.com", password: "secret")

    visit(login_path)
    ui.log_in("foo@bar.com", "secret")

    expect(current_path).to eq(account_path)
  end
end
```

The current Capybara::UI page is available at `ui` in your tests and is automatically reloaded to reflect the appropriate page whenever a new page loads.

## Compatibility

Capybara::UI is able to automatically reload when appropriate for the following Capybara drivers:

* Rack::Test
* Poltergeist

For other Capybara drivers, you can manually reload the UI:

```ruby
visit(login_path)
ui.reload
ui.log_in("foo@bar.com", "secret")
```

Even better, please submit a pull request to include automatic reload for your favorite Capybara driver.

## Thank You

Capybara::UI is inspired heavily by [Nick Gauthier's](https://github.com/ngauthier) [Domino](https://github.com/ngauthier/domino) gem, taken up a level to include page objects.
