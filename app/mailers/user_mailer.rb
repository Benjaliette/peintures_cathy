class UserMailer < ApplicationMailer
  def welcome
    @user = params[:user]

    mail(to: @user.email, subject: 'Bienvenue sur le site de CLIET Tableaux')
  end
end
