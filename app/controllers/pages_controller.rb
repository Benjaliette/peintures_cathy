class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ home contact artiste ]
  after_action :send_confirmation_mail, only: :success

  def home
  end

  def contact
    @message = Message.new
  end

  def ondemand
    @query = Query.new
  end

  def artiste
  end

  def success
  end

  def robots
    respond_to :text
  end

  private

  def send_confirmation_mail
    OrderMailer.with(user: current_user, order: current_user.orders.last).confirmation.deliver_now

    @user = User.first
    OrderMailer.with(user: current_user, order: current_user.orders.last, admin_user: @user).notification.deliver_now
  end
end
