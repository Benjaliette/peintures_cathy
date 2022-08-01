class MessageMailer < ApplicationMailer
  def contact
    @message = params[:message]

    mail(to: "admin@cliet-tableaux.com", subject: "Demande de contact de #{@message.name}")
  end
end
