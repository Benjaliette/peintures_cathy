class MessageMailer < ApplicationMailer
  def contact
    @message = params[:message]

    mail(to: "cliet.tableaux@gmail.com", subject: "Demande de contact de #{@message.name}")
  end
end
