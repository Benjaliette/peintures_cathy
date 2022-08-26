class QueryMailer < ApplicationMailer
  def query
    @query = params[:query]

    mail(to: "cliet.tableaux@gmail.com", subject: "Demande de peintures à la demande de #{@query.name}")
  end
end
