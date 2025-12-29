class MealPlan < ApplicationRecord
  belongs_to :recipe

  enum meal_type: { morning: 0, lunch: 1, dinner: 2 }

  before_validation :default_servings

  validates :plan_date, presence: true
  validates :meal_type, presence: true
  validates :servings, numericality: { greater_than: 0 }

  scope :within_week, ->(start_date, end_date) { where(plan_date: start_date..end_date) }

  private

  def default_servings
    self.servings = 1 if servings.blank?
  end
end
