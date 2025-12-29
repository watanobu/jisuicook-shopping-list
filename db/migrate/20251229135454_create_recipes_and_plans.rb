class CreateRecipesAndPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :image_url

      t.timestamps
    end

    create_table :ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :quantity, precision: 12, scale: 3, null: false
      t.string :unit, null: false
      t.boolean :condiment, null: false, default: false

      t.timestamps
    end

    create_table :meal_plans do |t|
      t.date :plan_date, null: false
      t.integer :meal_type, null: false, default: 0
      t.references :recipe, null: false, foreign_key: true
      t.decimal :servings, precision: 6, scale: 2, null: false, default: 1

      t.timestamps
    end

    add_index :meal_plans, [:plan_date, :meal_type]
  end
end
