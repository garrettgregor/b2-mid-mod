# As a user,
# When I visit the Employee show page,
# I see the employee's name, their department,
# and a list of all of their tickets from oldest to newest.
# I also see the oldest ticket assigned to the employee listed separately.

require "rails_helper"

RSpec.describe "/employees/:id", type: :feature do
  describe "employee show page" do
    before(:each) do
      @department_1 = Department.create!(name: "Backend", floor: "Annex")
      @employee_1 = @department_1.employees.create!(name: "Nero", level: 1)
      @employee_2 = @department_1.employees.create!(name: "Jessie", level: 2)
      @ticket_1 = Ticket.create!(subject: "printers broken", age: 1)
      @ticket_2 = Ticket.create!(subject: "cleaning", age: 2)
      @ticket_3 = Ticket.create!(subject: "cleaning supplies", age: 3)

      EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_1.id)
      EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_2.id)
      EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_3.id)

      visit employee_path(@employee_1)
    end

    it "has the employees name and department and list of tickets from oldest to newest" do
      expect(page).to have_content(@employee_1.name)
      expect(page).to have_content(@employee_1.department)
      expect(@ticket_3.subject).to appear_before(@ticket_2.subject)
      expect(@ticket_2.subject).to appear_before(@ticket_1.subject)
    end

    it "has the employees oldest ticket listed" do
      expect(page).to have_content("Oldest Ticket: #{@ticket_3.subject}")
    end
  end
end
