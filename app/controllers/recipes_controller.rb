class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.includes(:ingredients).order(:name)
  end

  def show; end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
  end

  def edit
    @recipe.ingredients.build if @recipe.ingredients.empty?
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: "レシピを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipes_path, notice: "レシピを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, notice: "レシピを削除しました。"
    else
      redirect_to recipes_path, alert: @recipe.errors.full_messages.to_sentence.presence || "削除に失敗しました。"
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :image_url,
      :photo,
      ingredients_attributes: %i[id name quantity unit condiment _destroy]
    )
  end
end
