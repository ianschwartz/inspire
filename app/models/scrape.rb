class Scrape
  require 'open-uri'
  def initialize
    @textpage = Nokogiri::HTML(open('https://www.reddit.com/r/quotes/new'))
    @imagepage = Nokogiri::HTML(open('https://www.flickr.com/explore/interesting/7days/'))
  end

  def text
    links = @textpage.css('div.link a.title')
    link = links[rand(25)].text
    link
  end

  def image
    link = @imagepage.at_css("td.Owner a")['href']
    page2 = Nokogiri::HTML(open("https://www.flickr.com#{link}"))
    # @image[rand(10)]['href']
    image = page2.at_css("img.main-photo")['src']
    "http:#{image}"
  end
end
