require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many(:employee_tickets) }
    it { should have_many(:tickets).through(:employee_tickets) }

    describe "instance methods" do
      before(:each) do
        @department_1 = Department.create!(name: "Furniture", floor: "House Goods")
        @employee_1 = @department_1.employees.create!(name: "Johnny", level: 1)
        @employee_2 = @department_1.employees.create!(name: "Bobby", level: 2)
        @employee_3 = @department_1.employees.create!(name: "Billy", level: 3)

        @ticket_1 = Ticket.create!(subject: "Fix Printer", age: 1)
        @ticket_2 = Ticket.create!(subject: "Defragment PC", age: 2)
        @ticket_3 = Ticket.create!(subject: "Vacuum", age: 3)
        @ticket_4 = Ticket.create!(subject: "Dust", age: 4)
        @ticket_5 = Ticket.create!(subject: "Move Monitors", age: 5)
        @ticket_6 = Ticket.create!(subject: "Send Emails", age: 6)

        EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_1.id)
        EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_2.id)
        EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_3.id)
        EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_4.id)
        EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_5.id)
        EmployeeTicket.create!(employee_id: @employee_1.id, ticket_id: @ticket_6.id)

        EmployeeTicket.create!(employee_id: @employee_2.id, ticket_id: @ticket_1.id)
        EmployeeTicket.create!(employee_id: @employee_3.id, ticket_id: @ticket_2.id)
      end

      context "#tickets_sorted_by_oldest_to_newest" do
        it "sorts tickets oldest to newest based on age" do
          results = [@ticket_6, @ticket_5, @ticket_4, @ticket_3, @ticket_2, @ticket_1]

          expect(@employee_1.tickets_sorted_by_oldest_to_newest).to eq(results)
        end
      end

      context "#oldest_ticket" do
        it "sorts tickets oldest to newest based on age" do
          expect(@employee_1.oldest_ticket).to eq(@ticket_6)
        end
      end

      context "#employees_with_shared_tickets" do
        it "shows employees with shared tickets" do
          results = [@employee_2, @employee_3]

          expect(@employee_1.employees_with_shared_tickets).to eq(results)
        end
      end
    end
  end
end
