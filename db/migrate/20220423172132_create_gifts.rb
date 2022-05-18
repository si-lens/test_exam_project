class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.text :categories, array: true, default: []
      t.timestamps
    end
  end
end
