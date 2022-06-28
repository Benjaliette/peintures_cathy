class PeinturesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @paintings = Painting.all
  end

  def show
  end
end
