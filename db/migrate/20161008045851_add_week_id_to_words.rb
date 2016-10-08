class AddWeekIdToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :week_id, :integer
  end
end
