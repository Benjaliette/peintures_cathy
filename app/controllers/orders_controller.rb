class OrdersController < ApplicationController
  def index
    @user = policy_scope(User).find(params[:user_id])
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def create
    @painting = policy_scope(Painting).find(params[:painting_id])
    @order  = Order.create!(painting: @painting, amount: @painting.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @painting.title,
        images: cl_image_path(@painting.photo.key),
        amount: @painting.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    @order.update(checkout_session_id: session.id)
    redirect_to new_peinture_paiement_path(@order)
  end
end
