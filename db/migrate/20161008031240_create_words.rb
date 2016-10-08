class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :letters
      t.string :pic

      t.timestamps
    end
  end
end
