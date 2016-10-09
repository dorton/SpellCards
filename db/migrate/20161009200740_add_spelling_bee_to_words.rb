class AddSpellingBeeToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :spelling_bee, :boolean, :default => false
  end
end
