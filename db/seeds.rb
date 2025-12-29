MealPlan.delete_all
Ingredient.delete_all
Recipe.delete_all

Recipe.create!(
  name: "焼き鮭定食",
  ingredients_attributes: [
    { name: "鮭", quantity: 1, unit: "切れ", condiment: false },
    { name: "塩", quantity: 1, unit: "適量", condiment: true },
    { name: "レモン", quantity: 0.25, unit: "個", condiment: false }
  ]
)

Recipe.create!(
  name: "野菜炒め",
  ingredients_attributes: [
    { name: "豚こま肉", quantity: 120, unit: "g", condiment: false },
    { name: "キャベツ", quantity: 120, unit: "g", condiment: false },
    { name: "もやし", quantity: 100, unit: "g", condiment: false },
    { name: "醤油", quantity: 1, unit: "さじ", condiment: true }
  ]
)

Recipe.create!(
  name: "カレーライス",
  ingredients_attributes: [
    { name: "カレールー", quantity: 1, unit: "皿分", condiment: false },
    { name: "玉ねぎ", quantity: 0.5, unit: "個", condiment: false },
    { name: "人参", quantity: 0.3, unit: "本", condiment: false },
    { name: "じゃがいも", quantity: 0.3, unit: "個", condiment: false },
    { name: "水", quantity: 200, unit: "ml", condiment: false }
  ]
)

puts "サンプルレシピを登録しました。"
