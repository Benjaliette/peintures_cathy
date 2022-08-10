class OrdersController < ApplicationController
  before_action :set_painting, only: %i[new create]

  def index
    @user = policy_scope(User).find(params[:user_id])
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
    authorize @order

    @painting = @order.painting
  end

  def new
    @order = Order.new
    authorize @order
  end

  def create
    @order  = Order.create!(painting: @painting, amount: @painting.price, state: 'pending', user: current_user)

    if @order.save
      session = set_stripe_session
      @order.update(checkout_session_id: session.id)
      authorize @order

      redirect_to session.url, allow_other_host: true
    else
      render :new
    end
  end

  def paiement
    @order = Order.find(params[:id])
    authorize @order
  end

  private

  def set_painting
    @painting = policy_scope(Painting).find(params[:painting_id])
  end

  def set_stripe_product
    Stripe::Product.create(
      name: @painting.title,
      images: [@painting.photo.url]
    )
  end

  def set_stripe_price(product)
    Stripe::Price.create({
      unit_amount: @painting.price_cents,
      currency: 'eur',
      product: product.id
    })
  end

  def set_stripe_customer
    Stripe::Customer.create({
      address: current_user.cut_address_in_parts,
      email: current_user.email,
      name: "#{current_user.first_name} #{current_user.last_name}",
      metadata: { id: current_user.id }
    })
  end

  def set_stripe_session
    customer = set_stripe_customer
    product = set_stripe_product
    price = set_stripe_price(product)

    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: price.id,
        quantity: 1,
      }],
      customer: customer,
      mode: 'payment',
      success_url: "#{success_pages_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: user_order_url(current_user, @order)
    )
  end
end
