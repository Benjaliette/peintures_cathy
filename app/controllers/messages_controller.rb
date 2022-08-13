class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @message = Message.new(message_params)
    if @message.valid?
      MessageMailer.with(message: @message).contact.deliver_now
      redirect_to available_paintings_path
      flash[:success] = "Nous avons bien reçu votre message et nous vous contacterons dès que possible"
    else
      flash[:notice] = "Il y a eu une erreur dans l'envoi de votre message. Veuillez recommander s'il vous plait."
      render 'pages/contact'
    end
  end

  private

  def message_params
      params.require(:message).permit(:name, :email, :body)
  end
end
