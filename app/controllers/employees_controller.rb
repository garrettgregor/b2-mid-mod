class EmployeesController < ApplicationController
  def show
    @employee = Employee.find_by id: params[:id]
    @old_tickets_first = @employee.sorted_tickets_oldest
  end
end
