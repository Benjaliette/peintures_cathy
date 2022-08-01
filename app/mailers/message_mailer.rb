class MessageMailer < ApplicationMailer
  def contact
    @message = params[:message]

    mail(to: "admain@cliet-tableaux.com", subject: "Demande de contact de #{@message.name}")
  end
end
