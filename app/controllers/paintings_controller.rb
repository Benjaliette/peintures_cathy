class PaintingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index available show]
  before_action :set_painting, only: %i[show edit update destroy]

  def index
    @paintings = policy_scope(Painting)
  end

  def available
    @paintings = policy_scope(Painting).where(sell: true)
  end

  def show
    @order = Order.new
  end

  def new
    @painting = Painting.new
    authorize @painting
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

  def edit
  end

  def update
    @painting.update(painting_params)

    if @painting.save
      redirect_to painting_path(@painting)
    else
      render :edit
    end
  end

  def destroy
    @painting.destroy

    flash[:alert] = 'Le tableau a été définitivement supprimé'
    redirect_to user_path(current_user)
  end

  private

  def set_painting
    @painting = Painting.find(params[:id])
    authorize @painting
  end

  def painting_params
    params.require(:painting).permit(:title, :description, :price, :sell, :photo)
  end
end
