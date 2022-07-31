class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.contact.subject
  #
  def contact
    @message = params[:message]

    mail(to: "admain@cliet-tableaux.com", subject: "Demande de contact de #{@message.name}"
  end
end
