require 'test_helper'
require 'minitest/autorun'
class EmployeeTest < ActiveSupport::TestCase
  test 'assigning gift to employee' do
    employee = employees(:kaja)
    mock = Minitest::Mock.new
    expected_gifts = [Gift.new(name: 'lab', categories: ['biology'], employee_id: nil)]
    mock.expect :call, expected_gifts, [employee.interests.first]
    Gift.stub :for_interest, mock do
      Employee.assign_gift(employee_id: employee.id)
    end
    mock.verify
    employee.reload
    assert_equal 'lab', employee.gift.name
  end

  test 'assigning gift to employee - no gifts available' do
    employee = employees(:natalia)
    result = Employee.assign_gift(employee_id: employee.id)
    assert_equal "No gifts available for you #{employee.name} :(", result
  end

  test 'assigning gift to employee with a gift' do
    employee = employees(:szymon)
    assert_raise Employee::OverridingGiftError do
      result = Employee.assign_gift(employee_id: employee.id)
    end
  end

  test 'assigning bunch of gifts to bunch of employees' do
    employees_json = File.read('db/seed_data/employees.json')
    gifts_json = File.read('db/seed_data/gifts.json')
    employees_hash = JSON.parse(employees_json)
    gifts_hash = JSON.parse(gifts_json)

    Employee.create!(employees_hash)
    Gift.create!(gifts_hash)
    assert_equal 1, Gift.where.not(employee_id: nil).count
    employees_with_gifts_ids = Gift.where.not(employee_id: nil).pluck(:id)
    Employee.where.not(id: employees_with_gifts_ids).each do |employee|
      Employee.assign_gift(employee_id: employee.id)
    end
    assert_equal 15, Gift.where.not(employee_id: nil).count
    employees_gifts = Employee.all.map { |e| e.gift&.name }.compact

    # Make sure no one got the same gift
    assert_equal employees_gifts, employees_gifts.uniq
  end
end
