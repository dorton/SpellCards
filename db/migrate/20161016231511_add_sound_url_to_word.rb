class AddSoundUrlToWord < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :sound_url, :string
  end
end
