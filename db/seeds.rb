# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


week = Week.create(start_date: '2016-10-09', end_date: '2016-10-16')

words = ['leg', 'dog', 'pen', 'duck', 'nest', 'den']

words.each do |word|
  nuword = Word.new
  nuword.letters = word
  pic = GoogleCustomSearchApi.search(word, searchType: "image")
  nuword.pic = pic.items.first.link
  nuword.save
  Week.last.words << nuword
end
