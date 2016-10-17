class SoundUrl < Hash
private
  def sound_url(word)
    url = "http://www.dictionaryapi.com/api/v1/references/learners/xml/#{word}?key=166499da-1133-42ca-99cb-21e2c5a006a5"
    encoded_url = URI.encode(url)
    sound = Nokogiri::XML(open(encoded_url) {|f| f.read}).at('sound').text
    sound_i = sound.first

    url = "http://media.merriam-webster.com/soundc11/#{sound_i}/#{sound}"

    url

  end



  # ResponseData.new(Crack::XML.parse(open('http://www.dictionaryapi.com/api/v1/references/learners/xml/can?key=166499da-1133-42ca-99cb-21e2c5a006a5') {|f| f.read}))
  # first picture is entry_list.entry.first.art.first.artref.id
  # first sound is entry_list.entry.first.sound.first.last
end
