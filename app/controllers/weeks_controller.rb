class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index]


  # GET /weeks
  # GET /weeks.json
  def index
    @weeks = Week.all
  end

  # GET /weeks/1
  # GET /weeks/1.json
  def show
    # @current_week = Week.where('end_date > ?', Date.today).where('start_date <= ?', Date.today).first
    @current_weeks_words = @week.words.shuffle
    @current_weeks_words = Word.search(params[:search]) if params[:search].present?
    @first_week = Week.first
    @last_week = Week.last
    @previous_week = @week.previous
    @next_week = @week.next
  end

  # GET /weeks/new
  def new
    @week = Week.new
    @current_week = Week.where('end_date >= ?', Date.today).where('start_date <= ?', Date.today)
  end

  # GET /weeks/1/edit
  def edit
  end

  # POST /weeks
  # POST /weeks.json
  def create
    @week = Week.new(week_params)
    @week.end_date = @week.start_date + 7
    @week.save
    redirect_to new_word_url, notice: 'Week was successfully created.'
  end

  # PATCH/PUT /weeks/1
  # PATCH/PUT /weeks/1.json
  def update
    respond_to do |format|
      if @week.update(week_params)
        format.html { redirect_to @week, notice: 'Week was successfully updated.' }
        format.json { render :show, status: :ok, location: @week }
      else
        format.html { render :edit }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weeks/1
  # DELETE /weeks/1.json
  def destroy
    @week.destroy
    respond_to do |format|
      format.html { redirect_to weeks_url, notice: 'Week was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week
      @week = Week.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def week_params
      params.fetch(:week, {}).permit(:start_date, :end_date)
    end
end
