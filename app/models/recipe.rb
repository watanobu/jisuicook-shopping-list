class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :meal_plans, dependent: :restrict_with_error
  has_one_attached :photo

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, length: { maximum: 100 }
  validate :at_least_one_ingredient

  before_validation :trim_name

  private

  def at_least_one_ingredient
    kept = ingredients.reject(&:marked_for_destruction?)
    errors.add(:base, "材料は1行以上入力してください") if kept.empty?
  end

  def trim_name
    self.name = name.strip if name
  end
end
