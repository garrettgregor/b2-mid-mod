class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def sorted_tickets_oldest
    tickets.order(age: :desc)
  end

  def oldest_ticket
    sorted_tickets_oldest.first
  end
end
