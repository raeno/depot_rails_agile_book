require "date"

class StoreController < ApplicationController
  def index
    @products = Product.order(:title)

    @datetime = Time.now.to_s(:ru_datetime)
    @counter = index_viewed

    @cart = current_cart
  end
end
