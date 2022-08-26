class QueriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @query = Query.new(query_params)

    if @query.valid?
      QueryMailer.with(query: @query).query.deliver_now
      redirect_to available_paintings_path
      flash[:success] = "Nous avons bien reçu votre message et nous vous contacterons dès que possible"
    else
      flash[:notice] = "Il y a eu une erreur dans l'envoi de votre message. Veuillez recommander s'il vous plait."
      render 'pages/contact'
    end
  end

  private

  def query_params
      params.require(:query).permit(:name, :email, :body, :photo)
  end
end
