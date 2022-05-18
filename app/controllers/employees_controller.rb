class EmployeesController < ApplicationController
  def claim_gift
    result = Employee.assign_gift(employee_id: params[:id])
    render json: result
  end
end
