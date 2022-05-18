class UpdateEmployeesColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :employees, :colors, :interests
  end
end
