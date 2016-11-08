class CreateWeekWords < ActiveRecord::Migration[5.0]
  def change
    create_table :week_words do |t|
      t.references :week, foreign_key: true
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
