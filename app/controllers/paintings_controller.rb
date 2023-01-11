class PaintingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index available show]
  before_action :set_painting, only: %i[show edit update destroy]

  add_breadcrumb "Peintures à vendre", :available_paintings_path

  def index
    @paintings = policy_scope(Painting)
  end

  def available
    @paintings = policy_scope(Painting).where(sell: true).order(updated_at: :desc)
  end

  def show
    @order = Order.new
    add_breadcrumb @painting.title, painting_path(@painting)
  end

  def new
    @painting = Painting.new
    authorize @painting
  end

  def create
    @painting = Painting.new(painting_params)
    authorize @painting

    if @painting.save
      redirect_to painting_path(@painting)
    else
      flash[:alert] = 'Il manque des infos au tableau !'
      render :new
    end
  end

  def edit
  end

  def update
    @painting.update(painting_params)

    redirect_to painting_path(@painting)
  end

  def destroy
    @painting.destroy

    flash[:alert] = 'Le tableau a été définitivement supprimé'
    redirect_to paintings_path, status: :see_other
  end

  private

  def set_painting
    @painting = Painting.friendly.find(params[:id])
    authorize @painting
  end

  def painting_params
    params.require(:painting).permit(:title, :description, :price, :sell, :photo)
  end
end
