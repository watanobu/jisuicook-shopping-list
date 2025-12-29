class ShoppingList
  Item = Struct.new(:name, :unit, :quantity, keyword_init: true)

  def initialize(meal_plans)
    @meal_plans = meal_plans
  end

  def items
    totals = Hash.new { |hash, key| hash[key] = 0.to_d }

    @meal_plans.each do |plan|
      plan.recipe.ingredients.each do |ingredient|
        next if ingredient.condiment?

        key = [ingredient.name, ingredient.unit]
        totals[key] += ingredient.quantity * plan.servings
      end
    end

    totals.map do |(name, unit), quantity|
      Item.new(name: name, unit: unit, quantity: quantity)
    end.sort_by { |item| [item.name, item.unit] }
  end
end
