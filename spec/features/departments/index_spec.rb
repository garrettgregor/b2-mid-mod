require "rails_helper"

RSpec.describe "/departments", type: :feature do
  let!(:department_1) { Department.create!(name: "IT", floor: "Basement") }
  let!(:employee_d1a) { department_1.employees.create!(name: "Christina Aguilera", level: 2) }
  let!(:employee_d1b) { department_1.employees.create!(name: "Britney Spears", level: 3) }

  let!(:department_2) { Department.create!(name: "Marketing", floor: "Roof") }
  let!(:employee_d2a) { department_2.employees.create!(name: "Charli XCX", level: 1) }
  let!(:employee_d2b) { department_2.employees.create!(name: "Taylor Swift", level: 10) }

  describe "when I visit the deparment index" do

    it "should display the department's name and floor" do
      visit departments_path

      within "#department-#{department_1.id}" do
        expect(page).to have_content("Department Name: #{department_1.name}")
        expect(page).to have_content("Department Floor: #{department_1.floor}")
      end

      within "#department-#{department_2.id}" do
        expect(page).to have_content("Department Name: #{department_2.name}")
        expect(page).to have_content("Department Floor: #{department_2.floor}")
      end
    end

    it "should display the department's employees" do
      visit departments_path

      within "#department-#{department_1.id}" do
        expect(page).to have_content("#{employee_d1a.name}")
        expect(page).to have_content("#{employee_d1b.name}")
        expect(page).to_not have_content("#{employee_d2a.name}")
        expect(page).to_not have_content("#{employee_d2b.name}")
      end

      within "#department-#{department_2.id}" do
        expect(page).to_not have_content("#{employee_d1a.name}")
        expect(page).to_not have_content("#{employee_d1b.name}")
        expect(page).to have_content("#{employee_d2a.name}")
        expect(page).to have_content("#{employee_d2b.name}")
      end
    end
  end
end
