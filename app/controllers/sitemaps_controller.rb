class SitemapsController < ApplicationController
  layout :false
  before_action :init_sitemap

  def index
    @paintings = Painting.where(sell: true)
  end

  private

  def init_sitemap
    headers['Content-Type'] = 'application/xml'
  end

end
