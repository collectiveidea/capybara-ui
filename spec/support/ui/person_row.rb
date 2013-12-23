class PersonRow < Capybara::UI::Element
  selector ".person"

  string :first_name
  string :last_name

  def name
    "#{first_name} #{last_name}"
  end
end
