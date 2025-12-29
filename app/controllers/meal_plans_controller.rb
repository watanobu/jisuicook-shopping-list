class MealPlansController < ApplicationController
  def create
    meal_plan = MealPlan.new(meal_plan_params)
    if meal_plan.save
      redirect_back fallback_location: plans_path, notice: "献立を追加しました。"
    else
      redirect_back fallback_location: plans_path, alert: meal_plan.errors.full_messages.to_sentence
    end
  end

  def update
    meal_plan = MealPlan.find(params[:id])
    if meal_plan.update(meal_plan_params)
      redirect_back fallback_location: plans_path, notice: "人数を更新しました。"
    else
      redirect_back fallback_location: plans_path, alert: meal_plan.errors.full_messages.to_sentence
    end
  end

  def destroy
    MealPlan.find(params[:id]).destroy
    redirect_back fallback_location: plans_path, notice: "献立を削除しました。"
  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:plan_date, :meal_type, :recipe_id, :servings)
  end
end
