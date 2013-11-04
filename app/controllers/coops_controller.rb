class CoopsController < ApplicationController
  before_action :set_coop, only: [:show, :edit, :update, :destroy]

  include CoopsHelper

  # GET /coops
  # GET /coops.json
  def index
    @coops = Coop.all
  end

  # GET /coops/1
  # GET /coops/1.json
  def show
    @breakfasts = Meal.where(coop: @coop, meal_type: 'breakfast', start_time: (Date.today..Date.today + 7))
    @lunches = Meal.where(coop: @coop, meal_type: 'lunch', start_time: (Date.today..Date.today + 7))
    @dinners = Meal.where(coop: @coop, meal_type: 'dinner', start_time: (Date.today..Date.today + 7))
    @days = weekFromToday
  end

  # GET /coops/new
  def new
    @coop = Coop.new
  end

  # GET /coops/1/edit
  def edit
  end

  # POST /coops
  # POST /coops.json
  def create
    @coop = Coop.new(coop_params)

    respond_to do |format|
      if @coop.save
        format.html { redirect_to @coop, notice: 'Coop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coop }
      else
        format.html { render action: 'new' }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coops/1
  # PATCH/PUT /coops/1.json
  def update
    respond_to do |format|
      if @coop.update(coop_params)
        Meal.generate_meals_for_coop(coop_params, @coop)
        format.html { redirect_to @coop, notice: 'Coop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coops/1
  # DELETE /coops/1.json
  def destroy
    @coop.destroy
    respond_to do |format|
      format.html { redirect_to coops_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop
      @coop = Coop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coop_params
      params.require(:coop).permit(:name, :bfast_time, :lunch_time, :dinner_time, :monday_breakfast, :tuesday_breakfast, :wednesday_breakfast, :thursday_breakfast, :friday_breakfast, :saturday_breakfast, :sunday_breakfast, :monday_lunch, :tuesday_lunch, :wednesday_lunch, :thursday_lunch, :friday_lunch, :saturday_lunch, :sunday_lunch, :monday_dinner, :tuesday_dinner, :wednesday_dinner, :thursday_dinner, :friday_dinner, :saturday_dinner, :sunday_dinner)
    end
end
