require "rails_helper"

RSpec.describe "/employees/:id", type: :feature do
  let!(:department_1) { Department.create!(name: "IT", floor: "Basement") }
  let!(:employee_d1a) { department_1.employees.create!(name: "Christina Aguilera", level: 2) }
  let!(:employee_d1b) { department_1.employees.create!(name: "Britney Spears", level: 3) }

  let!(:department_2) { Department.create!(name: "Marketing", floor: "Roof") }
  let!(:employee_d2a) { department_2.employees.create!(name: "Charli XCX", level: 1) }
  let!(:employee_d2b) { department_2.employees.create!(name: "Taylor Swift", level: 10) }

  let!(:ticket_1) { employee_d1a.tickets.create!(subject: "Fix Printer", age: 1) }
  let!(:ticket_2) { employee_d1a.tickets.create!(subject: "Defragment PC", age: 2) }
  let!(:ticket_3) { employee_d1a.tickets.create!(subject: "Vacuum", age: 3) }
  let!(:ticket_4) { employee_d1a.tickets.create!(subject: "Dust", age: 4) }
  let!(:ticket_5) { employee_d1a.tickets.create!(subject: "Move Monitors", age: 5) }
  let!(:ticket_6) { employee_d1a.tickets.create!(subject: "Send Emails", age: 6) }

  it "displays and employees name and department" do
    visit employee_path(employee_d1a)

    expect(page).to have_content("Employee Name: #{employee_d1a.name}")
    expect(page).to have_content("Department: #{employee_d1a.department.name}")
  end

  it "list all of their ticket from oldest to newest" do
    visit employee_path(employee_d1a)

    expect(page).to have_content("Employee Tickets:")
    expect("#{ticket_6.subject}").to appear_before("#{ticket_5.subject}")
    expect("#{ticket_5.subject}").to appear_before("#{ticket_4.subject}")
    expect("#{ticket_4.subject}").to appear_before("#{ticket_3.subject}")
    expect("#{ticket_3.subject}").to appear_before("#{ticket_2.subject}")
    expect("#{ticket_2.subject}").to appear_before("#{ticket_1.subject}")
  end

  it "also displays the oldest ticket assigned to the employee listed separately" do
    visit employee_path(employee_d1a)

    within "#oldest-ticket" do
      expect(page).to have_content("Oldest Ticket:")
      expect(page).to have_content("#{ticket_6.subject}")
    end
  end

end
