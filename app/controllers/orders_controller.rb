class OrdersController < ApplicationController
  before_action :set_painting, only: %i[new create]

  add_breadcrumb "Mes commandes", :user_orders_path

  def index
    @user = policy_scope(User).friendly.find(params[:user_id])
    @orders = @user.orders
  end

  def admin
    @orders = Order.all
    authorize @orders
  end

  def show
    @order = Order.friendly.find(params[:id])
    authorize @order

    @painting = @order.painting

    add_breadcrumb @order.painting.title, user_order_path(current_user, @order)
  end

  def detail
    @order = Order.friendly.find(params[:id])
    authorize @order

    @painting = @order.painting
    @user = @order.user
  end

  def new
    @order = Order.new
    authorize @order
  end

  def create
    current_user.update(user_params)

    @order = Order.new(order_params)
    @order.complete_order(current_user)
    authorize @order

    if @order.save
      session = @order.set_stripe_paiement(success_pages_url, user_order_url(current_user, @order))
      @order.update(checkout_session_id: session.id)

      redirect_to session.url, allow_other_host: true
    else
      render :new
    end
  end

  def paiement
    @order = Order.friendly.find(params[:id])
    authorize @order
  end

  private

  def order_params
    params.require(:order).permit(:address, :painting_id)
  end

  def user_params
    params.require(:user).permit(:address)
  end

  def set_painting
    @painting = policy_scope(Painting).friendly.find(params[:painting_id])
  end
end
