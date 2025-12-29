class PlansController < ApplicationController
  def index
    @start_date = Date.current
    @end_date = @start_date + 6
    @recipes = Recipe.order(:name)
    @meal_plans = MealPlan.includes(recipe: :ingredients).within_week(@start_date, @end_date).order(:plan_date, :meal_type, :created_at)
    @plans_by_slot = @meal_plans.group_by { |plan| [plan.plan_date, plan.meal_type] }
    @shopping_list = ShoppingList.new(@meal_plans).items
  end
end
