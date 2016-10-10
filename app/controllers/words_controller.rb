class WordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :voice
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  after_filter :set_header, only: :voice
  include Webhookable

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
    @words = Word.joins(:week).all
  end

  def spellingbee
    @word = Word.new
    @spellingbeewords = Word.where(spelling_bee: true)
  end

  def randombeewords
    @allspellingbeewords = Word.where(spelling_bee: true)
    @randomwords = Word.where(spelling_bee: true).limit(10).order("RANDOM()")
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
    @current_week = Week.where('end_date >= ?', Date.today).where('start_date <= ?', Date.today).first
    @current_weeks_words = Word.where(week_id: @current_week.id)
  end


  def show
  end

  def new
    @word = Word.new
    @current_week = Week.where('end_date >= ?', Date.today).where('start_date <= ?', Date.today)
  end

  def edit
  end


  def create
    @word = Word.new(word_params)
    pic = GoogleCustomSearchApi.search(@word.letters, searchType: "image")
    @word.pic = pic.items.first.link
    @word.save
    redirect_to @word, notice: 'Word was successfully created.'
  end

  def update
      @word.update(word_params)
      redirect_to @word, notice: 'Word was successfully updated.'
  end

  def destroy
    @word.destroy
    redirect_to spellingbee_path, notice: 'Word was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.fetch(:word, {}).permit(:letters, :pic, :week_id, :spelling_bee)
    end
end
