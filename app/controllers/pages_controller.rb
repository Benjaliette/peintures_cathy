class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  def home
  end

  def contact
  end

  def artiste
  end
end
