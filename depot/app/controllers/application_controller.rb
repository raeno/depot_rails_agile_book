class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  before_filter :set_i18n_locale_from_params

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please authorize to access this page"
    end
  end

  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include? params[:locale].to_sym
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    {locale: I18n.locale }
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

