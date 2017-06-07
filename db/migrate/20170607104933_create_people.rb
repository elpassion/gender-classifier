class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.integer :weight
      t.integer :height
      t.integer :gender

      t.timestamps
    end
  end
end
