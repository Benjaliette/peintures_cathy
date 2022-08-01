class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @message = Message.new(message_params)
    if @message.valid?
      MessageMailer.with(message: @message).contact.deliver_now
      redirect_to available_paintings_path
      # flash[:notice] = "We have received your message and will be in touch soon!"
    else
      # flash[:notice] = "There was an error sending your message. Please try again."
      render 'pages/contact'
    end
  end

  private

  def message_params
      params.require(:message).permit(:name, :email, :body)
  end
end
