require "rails_helper"

RSpec.describe "/departments/index" do
  # Story 1
  # Department Index

  # As a user,
  # When I visit the Department index page,
  # I see each department's name and floor
  # And underneath each department, I can see the names of all of its employees
  describe "index" do
    department_1 = Department.create!(name: "Furniture", floor: "House Goods")
    employee_1 = department_1.employees.create!(name: "Johnny", level: 1)
    employee_2 = department_1.employees.create!(name: "Jessie", level: 3)

    department_2 = Department.create!(name: "Appliances", floor: "House Goods")
    employee_3 = department_2.employees.create!(name: "Adam", level: 2)
    employee_4 = department_2.employees.create!(name: "Adrian", level: 5)

    department_3 = Department.create!(name: "Restaurant", floor: "Cafeteria")
    employee_5 = department_3.employees.create!(name: "Billy", level: 1)
    employee_6 = department_3.employees.create!(name: "Charlie", level: 2)

    it "lists all departments on one page" do
      visit "/departments"

      within "#department-#{department_1.id}" do
        expect(page).to have_content("Department Name: #{department_1.name}")
        expect(page).to have_content("Department Floor: #{department_1.floor}")
        expect(page).to_not have_content("Department Name: #{department_2.name}")
        expect(page).to have_content("Employee Name: #{employee_1.name}")
        expect(page).to have_content("Employee Name: #{employee_2.name}")
        expect(page).to_not have_content("Employee Name: #{employee_3.name}")
      end

      within "#department-#{department_2.id}" do
        expect(page).to have_content("Department Name: #{department_2.name}")
        expect(page).to have_content("Department Floor: #{department_2.floor}")
        expect(page).to have_content("Employee Name: #{employee_3.name}")
        expect(page).to have_content("Employee Name: #{employee_4.name}")
      end

      within "#department-#{department_3.id}" do
        expect(page).to have_content("Department Name: #{department_3.name}")
        expect(page).to have_content("Department Floor: #{department_3.floor}")
        expect(page).to have_content("Employee Name: #{employee_5.name}")
        expect(page).to have_content("Employee Name: #{employee_6.name}")
      end
    end
  end
end
