class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]


  def index
    @words = Word.all
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
      params.fetch(:word, {}).permit(:letters, :pic)
    end
end
