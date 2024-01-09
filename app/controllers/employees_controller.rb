class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @sorted_employee_tickets = @employee.tickets_sorted_by_oldest_to_newest
    @oldest_ticket = @employee.oldest_ticket
    @matching_employee_tickets = @employee.employees_with_shared_tickets
  end
end
