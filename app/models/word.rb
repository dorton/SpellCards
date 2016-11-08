class Word < ApplicationRecord
  has_many :weeks, through: :week_words
  has_many :week_words
  validates :letters, uniqueness: true, presence: true
  require 'csv'


  def self.search(search)
    where("letters ILIKE ?", "%#{search}%")
  end

  def self.import(file)
    word_array = CSV.read(file.path, headers: true)
    word_array.each do |word|
      newword = Word.new
      newword.letters = word.to_s(row_sep: nil)
      pic = GoogleCustomSearchApi.search(newword.letters, searchType: "image")
      newword.pic = pic.items.first.link
      newword.spelling_bee = true
      url = "http://www.dictionaryapi.com/api/v1/references/learners/xml/#{newword.letters}?key=166499da-1133-42ca-99cb-21e2c5a006a5"
      encoded_url = URI.encode(url)
      sound = Nokogiri::XML(open(encoded_url) {|f| f.read}).at('sound').text
      url = "http://media.merriam-webster.com/soundc11/#{sound.first}/#{sound}"
      newword.sound_url = url
      newword.save
    end
  end

end
