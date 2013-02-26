require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Megabook store order confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["just.raeno@gmail.com"], mail.from
    assert_match "/ Programming Ruby 1.9 x 1", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped
    assert_equal "Shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
