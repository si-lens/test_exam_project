class CreateAssociationBetweenEmployeesAndGifts < ActiveRecord::Migration[6.1]
  def change
    change_table :gifts do |t|
      t.belongs_to :employee, null: true
    end
  end
end
