class Employee < ApplicationRecord
  has_one :gift

  def self.assign_gift(employee_id:)
    employee = nil
    Employee.transaction do
      employee = Employee.find(employee_id)
      employee.lock!
      ensure_employee_has_no_gift(employee)
      employee.interests.each do |interest|
        gifts = Gift.for_interest(interest)
        next unless gifts.any?

        employee.gift = gifts.first
        employee.save!
        break
      end
    end
    gift_unavailable(employee) if employee.gift.blank?
  end

  def self.gift_unavailable(employee)
    "No gifts available for you #{employee.name} :("
  end

  def self.ensure_employee_has_no_gift(employee)
    raise OverridingGiftError if employee.gift.present?
  end

  def reveal_gift
    "Hello #{name}. Your gift is \"#{gift.name}\"" if gift.present?
  end

  OverridingGiftError = Class.new(StandardError)
end
