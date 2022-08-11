class OrderPaid
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')

    painting = order.painting
    painting.update(sell: false)
  end
end

StripeEvent.configure do |events|
  events.subscribe 'checkout.session.completed', OrderPaid.new
end
