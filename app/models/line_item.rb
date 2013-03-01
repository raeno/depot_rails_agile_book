class LineItem < ActiveRecord::Base
  include CurrencyConverter
  attr_accessible :cart_id, :product_id,:product, :cart
  belongs_to :product
  belongs_to :cart
  belongs_to :order


  def total_price
    from_usd(product.price,I18n.locale) * quantity

  end

end
