require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  context "instance methods" do
    let!(:department_1) { Department.create!(name: "IT", floor: "Basement") }
    let!(:employee_d1a) { department_1.employees.create!(name: "Christina Aguilera", level: 2) }

    let!(:ticket_1) { employee_d1a.tickets.create!(subject: "Fix Printer", age: 1) }
    let!(:ticket_2) { employee_d1a.tickets.create!(subject: "Defragment PC", age: 2) }
    let!(:ticket_3) { employee_d1a.tickets.create!(subject: "Vacuum", age: 3) }
    let!(:ticket_4) { employee_d1a.tickets.create!(subject: "Dust", age: 4) }
    let!(:ticket_5) { employee_d1a.tickets.create!(subject: "Move Monitors", age: 5) }
    let!(:ticket_6) { employee_d1a.tickets.create!(subject: "Send Emails", age: 6) }

    describe "#sorted_tickets_oldest" do
      it "sorts employee tickets oldest first" do
        expect(employee_d1a.sorted_tickets_oldest).to eq([ticket_6, ticket_5, ticket_4, ticket_3, ticket_2, ticket_1])
      end
    end

    describe "#oldest_ticket" do
      it "returns the subject for the oldest ticket" do
        expect(employee_d1a.oldest_ticket).to eq(ticket_6)
      end
    end
  end
end
