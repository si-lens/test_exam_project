class Gift < ApplicationRecord
  belongs_to :employee, optional: true

  def self.available
    Gift.where(employee_id: nil)
  end

  def self.for_interest(interest)
    available.where('? = ANY (categories)', interest).order('categories DESC')
  end
end
