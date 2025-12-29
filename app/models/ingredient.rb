class Ingredient < ApplicationRecord
  belongs_to :recipe

  UNITS = %w[g ml 個 枚 本 束 袋 缶 さじ 適量 切れ 皿分].freeze

  before_validation :normalize_text

  validates :name, presence: true
  validates :unit, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :condiment, inclusion: { in: [true, false] }

  private

  def normalize_text
    self.name = name.strip if name
    self.unit = unit.strip if unit
  end
end
