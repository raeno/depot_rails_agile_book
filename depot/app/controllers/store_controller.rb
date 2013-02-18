require "date"

class StoreController < ApplicationController
  def index
    @products = Product.order(:title)

    @datetime = Time.now.to_s(:ru_datetime)
  end
end
