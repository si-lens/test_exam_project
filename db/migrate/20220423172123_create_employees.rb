class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.text :interests, array: true, default: []
      t.timestamps
    end
  end
end
