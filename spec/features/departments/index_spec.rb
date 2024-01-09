# ### Story 1
# Department Index

# ```
# As a user,
# When I visit the Department index page,
# I see each department's name and floor
# And underneath each department, I can see the names of all of its employees
# ```
require "rails_helper"

RSpec.describe "/department", type: :feature do
  describe "department index page" do
    it "has the departments name and floor" do
      department_1 = Department.create!(name: "Backend", floor: "Annex")
      department_2 = Department.create!(name: "Cyber", floor: "Basement")
      department_3 = Department.create!(name: "IT", floor: "Roof")

      employee_1 = department_1.employees.create!(name: "Nero", level: 1)
      employee_2 = department_1.employees.create!(name: "Jessie", level: 2)
      employee_3 = department_2.employees.create!(name: "Adam", level: 3)
      employee_4 = department_2.employees.create!(name: "Adrian", level: 4)
      employee_5 = department_3.employees.create!(name: "Billy", level: 5)
      employee_6 = department_3.employees.create!(name: "Charlie", level: 6)

      visit departments_path
      # visit "/departments"
      within "#department-#{department_1.id}" do
        expect(page).to have_content(department_1.name)
        expect(page).to have_content(department_1.floor)
        expect(page).to_not have_content(department_2.name)
        expect(page).to_not have_content(department_3.name)
        expect(page).to have_content(employee_1.name)
        expect(page).to have_content(employee_2.name)
        expect(page).to_not have_content(employee_3.name)
        expect(page).to_not have_content(employee_5.name)
      end

      within "#department-#{department_2.id}" do
        expect(page).to have_content(department_2.name)
        expect(page).to have_content(department_2.floor)
        expect(page).to_not have_content(department_1.name)
        expect(page).to_not have_content(department_3.name)
        expect(page).to have_content(employee_3.name)
        expect(page).to have_content(employee_4.name)
        expect(page).to_not have_content(employee_1.name)
        expect(page).to_not have_content(employee_6.name)
      end
    end
  end
end
