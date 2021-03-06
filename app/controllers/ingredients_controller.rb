class IngredientsController < ApplicationController
    before_action :get_meal

    def create
        # byebug
        @meal.ingredients.create({food_id: params[:id]})

        ingredients = @meal.ingredients
        @included = []
        @calculations = 0
        ingredients.each do |food| 
            included = Food.where(id: food.food_id)
            included.each do |f|
                @included << f.nutrient_hash
                @calculations += f.calories
            end
        end
        @meal.update(nutrient_hash: @included)
        @meal.update(calorie_count: @calculations)
    end

    def index
        ingredients = @meal.ingredients
        @included = []
        @calculations = 0
        ingredients.each do |food| 
            included = Food.where(id: food.food_id)
            included.each do |f|
                @included << f
                @calculations += f.calories
            end
        end
       
        @meal.update(calorie_count: @calculations)
        render json: @included
    end

    def get_meal 
        @meal = Meal.find_by_id(params[:meal_id])
    end
    
end
