require "support/ui/person_row"

class PeoplePage < Capybara::UI
  path "/people.html"

  has_many :people, class_name: "PersonRow"
end
