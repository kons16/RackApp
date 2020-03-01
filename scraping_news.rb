require 'nokogiri'
require 'open-uri'
require 'json'


class ScrapingNews

  def scraping
    url = "https://news.yahoo.co.jp/flash"
    charset = nil
    html = open(url) do |f|
      f.read
    end

    news_hash = {}
    news_ary = []
    doc = Nokogiri::HTML.parse(html)
    doc.xpath('//div[@class="newsFeed_item_title"]').each do |node|
      news_title =  node.text
      news_ary.push(news_title)
    end
    news_hash["title"] = news_ary
    return news_hash.to_hash
  end

end
