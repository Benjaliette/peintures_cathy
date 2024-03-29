class OrderPaid
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')

    painting = painting.order
    painting.update(sell: false)
  end
end
