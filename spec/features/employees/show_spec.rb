require "rails_helper"

RSpec.describe "/employees/:id" do
  describe "employee show page" do
    before(:each) do
      @department_1 = Department.create!(name: "Furniture", floor: "House Goods")
      @employee_1 = @department_1.employees.create!(name: "Johnny", level: 1)
      @employee_2 = @department_1.employees.create!(name: "Jessie", level: 3)

      @department_2 = Department.create!(name: "Appliances", floor: "House Goods")
      @employee_3 = @department_2.employees.create!(name: "Adam", level: 2)
      @employee_4 = @department_2.employees.create!(name: "Adrian", level: 5)

      @department_3 = Department.create!(name: "Restaurant", floor: "Cafeteria")
      @employee_5 = @department_3.employees.create!(name: "Billy", level: 1)
      @employee_6 = @department_3.employees.create!(name: "Charlie", level: 2)

      @ticket_1 = Ticket.create!(subject: "Fix Printer", age: 1)
      @ticket_2 = Ticket.create!(subject: "Defragment PC", age: 2)
      @ticket_3 = Ticket.create!(subject: "Vacuum", age: 3)
      @ticket_4 = Ticket.create!(subject: "Dust", age: 4)
      @ticket_5 = Ticket.create!(subject: "Move Monitors", age: 5)
      @ticket_6 = Ticket.create!(subject: "Send Emails", age: 6)

      EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_1.id)
      EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_2.id)
      EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_3.id)
      EmployeeTicket.create!(employee_id: @employee_4.id, ticket_id: @ticket_4.id)
      EmployeeTicket.create!(employee_id: @employee_4.id, ticket_id: @ticket_5.id)
      EmployeeTicket.create!(employee_id: @employee_4.id, ticket_id: @ticket_6.id)
      EmployeeTicket.create!(employee_id: @employee_5.id, ticket_id: @ticket_1.id)
      EmployeeTicket.create!(employee_id: @employee_6.id, ticket_id: @ticket_1.id)
    end

    # Story 2
    # Employee Show

    # As a user,
    # When I visit the Employee show page,
    # I see the employee's name, their department,
    # and a list of all of their tickets from oldest to newest.
    # I also see the oldest ticket assigned to the employee listed separately.
    it "shows information for a specific employee(1)" do
      visit employee_path(@employee_1)
      # visit "/employees/#{@employee_1.id}"

      expect(page).to have_content("Employee Name: #{@employee_1.name}")
      expect(page).to have_content("Employee Department: #{@employee_1.department.name}")
      expect(@ticket_3.subject).to appear_before(@ticket_2.subject)
      expect(@ticket_2.subject).to appear_before(@ticket_1.subject)
      expect(page).to have_content("Oldest Ticket: #{@ticket_3.subject}")
    end

    it "shows information for a specific employee(4)" do
      visit employee_path(@employee_4)
      # visit "/employees/#{@employee_4.id}"

      expect(page).to have_content("Employee Name: #{@employee_4.name}")
      expect(page).to have_content("Employee Department: #{@employee_4.department.name}")
      expect(@ticket_6.subject).to appear_before(@ticket_5.subject)
      expect(@ticket_5.subject).to appear_before(@ticket_4.subject)
      expect(page).to have_content("Oldest Ticket: #{@ticket_6.subject}")
    end

    # Story 3
    # As a user,
    # When I visit the employee show page,
    # I do not see any tickets listed that are not assigned to the employee
    # and I see a form to add a ticket to this employee.
    # When I fill in the form with the id of a ticket that already exists in the database
    # and I click submit
    # Then I am redirected back to that employees show page
    # and I see the ticket's subject now listed.
    # (you do not have to test for sad path, for example if the id does not match an existing ticket.)
    it "has a form to add a ticket for an employee" do
      visit employee_path(@employee_2)

      expect(page).to_not have_content(@ticket_1.subject)
      expect(page).to have_content("Add Ticket")

      fill_in(:ticket_id, with: @ticket_1.id)
      click_button("Submit")

      expect(current_path).to eq(employee_path(@employee_2))
      # expect(current_path).to eq("/employees/#{@employee_2.id}")

      expect(page).to have_content(@ticket_1.subject)
      expect(page).to have_content("Oldest Ticket: #{@ticket_1.subject}")
    end

    # Best Friends

    # As a user,
    # When I visit an employee's show page
    # I see that employees name and level
    # and I see a unique list of all the other employees that this employee shares tickets with
    it "has a form to add a ticket for an employee" do
      visit employee_path(@employee_5)
      # visit "/employees/#{@employee_5.id}"

      expect(page).to have_content(@employee_5.name)
      expect(page).to have_content("Employee Level: #{@employee_5.level}")

      within "#shared-tickets" do
        expect(page).to have_content("Shared Tickets")
        expect(page).to have_content("#{@employee_6.name}")
        expect(page).to have_content("#{@employee_1.name}")
      end
    end
  end
end
