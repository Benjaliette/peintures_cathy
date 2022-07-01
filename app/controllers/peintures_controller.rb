class PeinturesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @paintings = policy_scope(Painting)
  end

  def show
    @painting = Painting.find(params[:id])
  end

  def new
    @painting = Painting.new
  end

  def create
    @painting = Painting.new(painting_params)
    authorize @painting

    if @painting.save!
      redirect_to painting_path(@painting)
    else
      render :new
    end
  end

  private

  def painting_params
    params.require(:painting).permit(:title, :description)
  end
end
