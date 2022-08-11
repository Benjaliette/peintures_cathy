class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ home contact artiste ]

  def home
  end

  def contact
    @message = Message.new
  end

  def artiste
  end

  def success
  end

  def robots
    respond_to :text
  end
end
