class WordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :voice
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  after_filter :set_header, only: :voice
  include Webhookable

  def voice
    @word = Word.find(params[:id])
    response = Twilio::TwiML::Response.new do |r|
      r.Say "#{@word}"
    end
    render_twiml response
  end

  def wordlist
    @words = Word.all
  end

  def index
    @words = Word.all
    @current_weeks_words = Word.where(week_id: Week.last.id)
    @current_week = Week.last
  end


  def show
  end

  def new
    @word = Word.new
  end

  def edit
  end


  def create
    @word = Word.new(word_params)
    pic = GoogleCustomSearchApi.search(@word.letters, searchType: "image")
    @word.pic = pic.items.first.link
    @word.save
    Week.last.words << @word
    redirect_to @word, notice: 'Word was successfully created.'
  end

  def update
      @word.update(word_params)
      redirect_to @word, notice: 'Word was successfully updated.'
  end

  def destroy
    @word.destroy
    redirect_to words_url, notice: 'Word was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.fetch(:word, {}).permit(:letters, :pic, :week_id)
    end
end
