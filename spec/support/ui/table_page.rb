class TablePage < Capybara::UI
  path /table/

  has_many :people, class_name: "PersonRow"
end
