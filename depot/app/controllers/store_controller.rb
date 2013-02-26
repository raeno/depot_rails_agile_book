require "date"

class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.order(:title)

    @datetime = Time.now.to_s(:ru_datetime)
    @counter = index_viewed

    @cart = current_cart
  end
end
