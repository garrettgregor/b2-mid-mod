# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def tickets_sorted_by_oldest_to_newest
    tickets.order(age: :desc)
  end

  def oldest_ticket
    tickets.order(age: :desc).first
  end

  def employees_with_shared_tickets
    ticket_ids = tickets.pluck(:id)
    employee_ids = EmployeeTicket.where(ticket_id: ticket_ids).where.not(employee_id: id).pluck(:employee_id).uniq
    Employee.where(id: employee_ids)
  end
end
