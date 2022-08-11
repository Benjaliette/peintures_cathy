xml.instruct! :xml, version: '1.0'
xml.tag! 'sitemapindex', 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.tag! 'url' do
    xml.tag! 'loc', root_url
  end

  xml.tag! 'url' do
    xml.tag! 'loc', contact_pages_url
  end

  xml.tag! 'url' do
    xml.tag! 'loc', artiste_pages_url
  end

  xml.tag! 'url' do
    xml.tag! 'loc', available_paintings_url
  end

  @paintings.each do |painting|
    xml.tag! 'url' do
      xml.tag! 'loc', painting_url(painting)
      xml.lastmod painting.updated_at.strftime("%F")
    end
  end

end
