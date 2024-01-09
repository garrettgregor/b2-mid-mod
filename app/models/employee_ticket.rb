# frozen_string_literal: true

class EmployeeTicket < ApplicationRecord
  belongs_to :employee
  belongs_to :ticket
end
