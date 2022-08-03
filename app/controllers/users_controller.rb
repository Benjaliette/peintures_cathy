class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @paintings = Painting.all
  end

  def edit
  end

  def update
    @user.update(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:photo)
  end
end
