# encoding: UTF-8
class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates_length_of :title, :minimum => 10
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: "URL должен указывать на gif, jpg или png"
  }

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add("base", 'есть товары в корзине')
      return false
    end
  end

end
