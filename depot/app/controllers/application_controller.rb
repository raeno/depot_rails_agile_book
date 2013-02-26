class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please authorize to access this page"
    end
  end

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

  def reset_index_counter
    session[:counter] = 0
  end

end

