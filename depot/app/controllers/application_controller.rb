class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    return cart
  end

  def index_viewed
    if session[:counter].nil?
      session[:counter] = 0
    end
    counter = session[:counter] + 1
    session[:counter] = counter
    counter
  end

end
