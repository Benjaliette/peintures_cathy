class OrderMailer < ApplicationMailer
  def confirmation
    @user = params[:user]
    @order = params[:order]

    mail(to: @user.email, subject: 'Confirmation de votre commande sur CLIET-tableaux.com')
  end

  def notification
    @user = params[:user]
    @order = params[:order]
    @admin_user = params[:admin_user]

    mail(to: 'cliet-tableaux@gmail.com', subject: "Commande d'un tableau!")
  end
end
