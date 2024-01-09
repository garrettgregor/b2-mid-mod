# frozen_string_literal: true

class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end
end
