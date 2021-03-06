module Api
  module V1
    class WeeksController < ApplicationController
        respond_to :json
        # GET /weeks
        # GET /weeks.json
        def index
          @weeks = Week.all
          render json: @weeks
        end

        # GET /weeks/1
        # GET /weeks/1.json
        def show
          @week = Week.find(params[:id])
          render json: @week
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
            @weekly_words = @week.words
          end

          # Never trust parameters from the scary internet, only allow the white list through.
          def week_params
            params.fetch(:week, {}).permit(:start_date, :end_date)
          end
    end
  end
end
