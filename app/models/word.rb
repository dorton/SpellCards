class Word < ApplicationRecord
  belongs_to :week, optional: true
  require 'csv'

  def self.import(file)
    word_array = CSV.read(file.path, headers: true)
    word_array.each do |word|
      newword = Word.new
      newword.letters = word
      pic = GoogleCustomSearchApi.search(newword.letters, searchType: "image")
      newword.pic = pic.items.first.link
      newword.spelling_bee = true
      newword.save
    end
  end

end
