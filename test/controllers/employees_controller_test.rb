require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:kaja)
  end

  test 'employee should receive gift' do
    employee = employees(:kaja)
    get claim_gift_path(id: employee.id)
    assert employee.gift
    assert_response :success
  end
  test 'employee should not receive gift' do
    employee = employees(:szymon)
    assert_raise Employee::OverridingGiftError do
      get claim_gift_path(id: employee.id)
    end
  end
end
