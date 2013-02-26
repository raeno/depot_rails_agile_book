require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do

    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    #open index
    get "/"
    assert_response :success
    assert_template 'index'

    #add ruby_book to cart
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    # check book successfully added
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    # checkout order
    get '/orders/new'
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders", order: { name:       "Dave Thomas",
                                          address:    "123 The Street",
                                          email:      "dave@example.com",
                                          pay_type:   "Check"}
    assert_response :success
    assert_template "index"

    # check cart is empty after order complete
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # check order customer info
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type

    # and that we've ordered right book
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    # check that mail delivered and contained correct info
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal "just.raeno <just.raeno@gmail.com>", mail[:from].value
    assert_equal "Megabook store order confirmation", mail.subject

  end
end
