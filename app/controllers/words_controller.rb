class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :newbee, :createbee, :edit, :update, :destroy]


  def search
    @words = Word.all.order('letters DESC')
    @words = @words.search(params[:search]) if params[:search].present?
  end

  def import
    Word.import(params[:file])
    redirect_to spellingbee_path, notice: "Spelling Bee Words imported."
  end

  def voice
    @word = Word.find(params[:id])
    response = Twilio::TwiML::Response.new do |r|
      r.Say "#{@word}"
    end
    render_twiml response
  end

  def wordlist
    @words = Word.joins(:week).order("weeks.start_date DESC").all
    @words = @words.search(params[:search]) if params[:search].present?

  end

  def spelling_bee_practice
    @allspellingbeewords = Word.where(spelling_bee: true).shuffle
    @allspellingbeewords = Word.where(spelling_bee: true).search(params[:search]) if params[:search].present?

  end

  def spellingbee
    @word = Word.new
    @spellingbeewords = Word.where(spelling_bee: true).sort_by{|i| i.letters}
    @spellingbeewords = Word.where(spelling_bee: true).search(params[:search]) if params[:search].present?

  end

  def randombeewords
    @allspellingbeewords = Word.where(spelling_bee: true)
    @randomwords = Word.where(spelling_bee: true).limit(6).order("RANDOM()")
  end

  def newbee
    @word = Word.new
  end

  def createbee
    @word = Word.new(word_params)
    pic = GoogleCustomSearchApi.search(@word.letters, searchType: "image")
    @word.pic = pic.items.first.link
    @word.save
    redirect_to spellingbee_path, notice: 'Spelling Bee Word was successfully created.'
  end


  def index
    @words = Word.all
    @current_week = Week.where('end_date > ?', Date.today).where('start_date <= ?', Date.today).first
    @current_weeks_words = Word.where(week_id: @current_week.id).shuffle
    @current_weeks_words = Word.search(params[:search]) if params[:search].present?
  end


  def show
  end

  def new
    @word = Word.new
    @current_week = Week.where('end_date > ?', Date.today).where('start_date <= ?', Date.today).first
  end

  def edit
  end


  def create
    @word = Word.new(word_params)
    pic = GoogleCustomSearchApi.search(@word.letters, searchType: "image")
    @word.pic = pic.items.first.link
    if @word.save
      url = "http://www.dictionaryapi.com/api/v1/references/learners/xml/#{@word.letters}?key=166499da-1133-42ca-99cb-21e2c5a006a5"
      encoded_url = URI.encode(url)
      sound = Nokogiri::XML(open(encoded_url) {|f| f.read}).at('sound').text
      url = "http://media.merriam-webster.com/soundc11/#{sound.first}/#{sound}"
      @word.update_attributes(sound_url: url)
      redirect_to @word, notice: 'Word was created.'
    else
      redirect_to new_word_path, notice: 'Word already present.'
    end
  end

  def update
      @word.update(word_params)
      redirect_to @word, notice: 'Word was updated.'
  end

  def destroy
    @word.destroy
    redirect_to spellingbee_path, notice: 'Word was destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.fetch(:word, {}).permit(:letters, :pic, :week_id, :spelling_bee, :sound_url, :search)
    end
end
